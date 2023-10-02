# planet-mbtiles

## Goal

Given a Planet PBF File from OpenStreetMap, we want to generate a single [MBTiles](https://wiki.openstreetmap.org/wiki/MBTiles) file for use in a Tile Server such as [mbtileserver](https://github.com/consbio/mbtileserver).

## Prerequisites

- [Osmium](https://wiki.openstreetmap.org/wiki/Osmium)

## Process

1. Download **Latest Weekly Planet PBF File** from [Planet OSM](https://planet.openstreetmap.org/). This should download a `.osm.pbf` file.
2. Run `osmium fileinfo planet-xxx.osm.pbf`. Ensure `Bounding boxes` is listed as (-180, -90, 180, 90).
