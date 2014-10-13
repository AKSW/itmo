#!/bin/bash

#./sparqlify-all.sh

DATA_DIR=$(dirname $(pwd))/data
DATA_FILE=$DATA_DIR/itmo.nt
head $DATA_FILE

#DROP THE GRAPH
#/usr/local/virtuoso-opensource/bin/isql "1111" "dba" "what_time_is_it_now_sir?" "sparql DROP GRAPH http://lod.ifmo.ru"
#LOAD THE GRAPH
virtload $DATA_FILE http://lod.ifmo.ru
