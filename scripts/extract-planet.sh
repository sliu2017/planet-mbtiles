#!/usr/bin/env bash

# Display Help
help () {
  echo "Usage: ./extract-planet.sh [OPTIONS] [FILE]"
  echo "Extract segmented .osm.pbf files from a planet-xxx.osm.pbf file using Osmium."
  echo
  echo "Options"
  echo "    -h        display this help and exit"
}

lat=-90
long=-180
lat_seg=1
long_seg=1

if [[ $# -eq 0 ]]
then
  help
  exit
fi

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

echo "Extracting ${planet_file}..."

while [[ $lat_seg -le 180 ]] ; do
  while [[ $long_seg -le 360 ]] ; do
    lat_pos=$((lat+lat_seg-1))
    long_pos=$((long+long_seg-1))
    lat_next_pos=$((lat+lat_seg))
    long_next_pos=$((long+long_seg))
    echo "Generating segment ${lat_seg}-${long_seg} at bbox ${lat_pos},${long_pos},${lat_next_pos},${long_next_pos}..."
    osmium extract -b $long_pos,$lat_pos,$long_next_pos,$lat_next_pos $planet_file -o planet-extract-$epoch_time-$lat_seg-$long_seg.osm.pbf -O
    long_seg=$((long_seg+1))
  done
  lat_seg=$((lat_seg+1))
  long_seg=1
done

