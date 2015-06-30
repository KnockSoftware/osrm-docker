# Docker image for OSRM

This project lets you prepare and run a docker container with OSRM and the map of your choice.

This repository references a modified version of OSRM with a wacky matching plugin. This is useful for Ride, but maybe not for other applications.

## Run with `fig` or `docker-compose`

You only need to specify the environment variable `OSM_PBF_URL`. The docker
container will download the data, prepare, extract, and begin accepting routing
requests on port 5000.

```yaml
osrm:
  image: ezheidtmann/osrm
  environment:

    # Filename is optional but may help if you are running two different
    # regions or data sets in the same docker.
    OSRM_FILENAME: oregon

    # For a full list of available extracts, see http://download.geofabrik.de/
    OSM_PBF_URL: http://download.geofabrik.de/north-america/us/oregon-latest.osm.pbf
```
