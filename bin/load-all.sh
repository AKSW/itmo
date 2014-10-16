#!/bin/bash

#transform the data
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#$CURRENT_DIR/sparqlify-all.sh

DATA_DIR=$(dirname $(pwd))/data
DATA_FILE=$DATA_DIR/itmo.nt
for file in $DATA_DIR/*.nt; 
do
  cat $file;
done 2>/dev/null >> $DATA_DIR/itmo.nt
#load into virtuoso
virtload $DATA_FILE http://lod.ifmo.ru
