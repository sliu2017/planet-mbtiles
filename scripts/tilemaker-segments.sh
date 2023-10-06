#!/usr/bin/env bash

# Display Help
help () {
  echo "Usage: ./tilemaker-segments.sh [OPTIONS]"
  echo "Convert segment planet-extract-t-x-y.osm.pbf files to a planet-extract-t-x-y.mbtiles file using Tilemaker."
  echo
  echo "Options"
  echo "    -h        display this help and exit"
}

lat=-90
long=-180
lat_seg=1
long_seg=1
segment_size=12

# if [[ $# -eq 0 ]]
# then
#   help
#   exit
# fi

while getopts ":h" option; do
  case $option in
    h) # Display Help
      help
      exit;;
    \?) # Invalid option
      echo "Error: Invalid option"
      exit;;
  esac
done

planet_file=$1
epoch_time=`date +"%s"`

echo "Converting segments..."

lat_seg_count=15
long_seg_count=30

while [[ $lat_seg -le lat_seg_count ]] ; do
  while [[ $long_seg -le long_seg_count ]] ; do
    lat_pre_seg=$((lat_seg-1))
    long_pre_seg=$((long_seg-1))
    lat_pos=$((lat+lat_pre_seg*segment_size))
    long_pos=$((long+long_pre_seg*segment_size))
    lat_next_pos=$((lat+lat_seg*segment_size))
    long_next_pos=$((long+long_seg*segment_size))
    echo "Converting segment ${lat_seg}-${long_seg}..."
    docker run --rm -it -v $(pwd):/srv tilemaker --bbox $long_pos,$lat_pos,$long_next_pos,$lat_next_pos --input=/srv/planet-extract-1696230387-$lat_seg-$long_seg.osm.pbf --output=/srv/mbtiles/planet-extract-$epoch_time-$lat_seg-$long_seg.mbtiles
    long_seg=$((long_seg+1))
  done
  lat_seg=$((lat_seg+1))
  long_seg=1
done
