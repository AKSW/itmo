#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR=$(dirname $CURRENT_DIR)
rm $ROOT_DIR/mappings/all.sml
for D in `find $ROOT_DIR/mappings -type d`
do
  for file in $D/*.sml; do cat $file; done >> $ROOT_DIR/mappings/all.sml
done
sparqlify -D -U ISU_SEMANTIC -W fltu1632 -j jdbc:oracle:thin:ISU_SEMANTIC/fltu1632@192.168.1.2:1521/oracis -m $ROOT_DIR/mappings/all.sml | tee $ROOT_DIR/data/itmo.nt
