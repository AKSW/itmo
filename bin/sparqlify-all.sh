#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR=$(dirname $CURRENT_DIR)
rm $ROOT_DIR/mappings/all.sml
for D in `find $ROOT_DIR/mappings -type d`
do
  for file in $D/*.sml; 
  do 
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"
    sparqlify -D -U ISU_SEMANTIC -W fltu1632 -j jdbc:oracle:thin:ISU_SEMANTIC/fltu1632@192.168.1.2:1521/oracis -m $file | tee $ROOT_DIR/data/$filename.nt
  done 
done
