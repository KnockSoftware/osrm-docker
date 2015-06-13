#!/bin/bash
DATA_PATH=${DATA_PATH:="/data"}

_sig() {
  kill -TERM $child 2>/dev/null
}

trap _sig SIGKILL SIGTERM SIGHUP SIGINT EXIT

mkdir -p /data

if [ ! -f $DATA_PATH/$OSRM_FILENAME.osrm ]; then
    curl $OSM_PBF_URL > $DATA_PATH/$OSRM_FILENAME.osm.pbf
    ./osrm-extract $DATA_PATH/$OSRM_FILENAME.osm.pbf
    ./osrm-prepare $DATA_PATH/$OSRM_FILENAME.osrm
fi

./osrm-routed $DATA_PATH/$OSRM_FILENAME.osrm &
child=$!
wait "$child"
