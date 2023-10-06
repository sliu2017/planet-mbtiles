#!/usr/bin/env bash

# Display Help
help () {
  echo "Usage: ./missing-mbtiles.sh [OPTIONS]"
  echo "Display missing mbtiles from tilemaker-segments.sh."
  echo
  echo "Options"
  echo "    -h        display this help and exit"
}

lat_seg=1
long_seg=1

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

lat_seg_count=15
long_seg_count=30

while [[ $lat_seg -le lat_seg_count ]] ; do
  while [[ $long_seg -le long_seg_count ]] ; do
    if [ ! -f "planet-extract-1696466214-${lat_seg}-${long_seg}.mbtiles" ] ;
    then
      echo "planet-extract-1696466214-${lat_seg}-${long_seg}.mbtiles"
    fi
    long_seg=$((long_seg+1))
  done
  lat_seg=$((lat_seg+1))
  long_seg=1
done
