#!/bin/bash

#transform the data
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
while true; do
  read -p "Do you wish to transform all the data? (may take several minutes) [yn] " yn
    case $yn in
        [Yy]* ) $CURRENT_DIR/sparqlify-all.sh; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

DATA_DIR=$(dirname $(pwd))/data
DATA_FILE=$DATA_DIR/itmo_dev.nt
mv $DATA_FILE $DATA_FILE.old
ERROR=0
for file in $DATA_DIR/*.nt;
do
  FILESIZE=$(stat -c%s $file)
  if [ $FILESIZE -eq 0 ];
  then
    echo "$file is empty" >>  errors.txt
    $ERROR=1
  else
    grep "^<http" $file;
  fi;
done 2>/dev/null >> $DATA_DIR/itmo_dev.nt
#load into virtuoso
# if [ $ERROR -eq 0 ];
# then
#   echo "No empty files deleted. Loading to the server"
#   virtload $DATA_FILE http//lod.ifmo.ru:9000
# else
#   echo "Some of the files are not converted correctly (contains no data)"
# fi;
