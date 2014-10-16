#!/bin/bash

#transform the data
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#$CURRENT_DIR/sparqlify-all.sh

DATA_DIR=$(dirname $(pwd))/data
DATA_FILE=$DATA_DIR/itmo.nt
ERROR=0
for file in $DATA_DIR/*.nt; 
do
  FILESIZE=$(stat -c%s $file)
  if [ $FILESIZE -eq 0 ]; 
  then
    echo "$file got errors" | tee -a errors.txt
    $ERROR=1
  else
    echo "$file is okay"
    cat $file;
  fi;
done 2>/dev/null >> $DATA_DIR/itmo.nt
#load into virtuoso
if [ $ERROR -eq 0 ];
then
  echo "loading to the server"
  #virtload $DATA_FILE http://lod.ifmo.ru
else
  echo "Some of the files are not converted correctly (contains no data)"
fi;
