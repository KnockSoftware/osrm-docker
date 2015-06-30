FROM ubuntu:14.04

ENV OSRM_REVISION match-pristine-v0
ENV OSM_PBF_URL http://download.geofabrik.de/north-america/us/oregon-latest.osm.pbf
ENV OSRM_FILENAME oregon

RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git curl \
    cmake pkg-config libprotoc-dev libprotobuf8 protobuf-compiler \
    libprotobuf-dev libosmpbf-dev libpng12-dev libtbb-dev libbz2-dev \
    libstxxl-dev libstxxl-doc libstxxl1 libxml2-dev libzip-dev \
    libboost-all-dev lua5.1 liblua5.1-0-dev libluabind-dev libluajit-5.1-dev

RUN \
  git clone --depth 1 --branch "$OSRM_REVISION" https://github.com/KnockSoftware/osrm-backend.git /src && \
  mkdir -p /build && \
  cd /build && \
  cmake /src && make && \
  mv /src/profiles/bicycle.lua profile.lua && \
  mv /src/profiles/lib/ lib && \
  echo 'disk=/data/stxxl,0,syscall' > /build/.stxxl && \
  rm -rf /src

VOLUME /data
WORKDIR /build
ADD run.sh run.sh
EXPOSE 5000
CMD ./run.sh
