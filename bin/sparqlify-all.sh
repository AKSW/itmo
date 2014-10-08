#!/bin/bash

rm ../mappings/all.sml
for file in ../mappings/*.sml; do cat $file; done > ../mappings/all.sml
sparqlify -D -U ISU_SEMANTIC -W fltu1632 -j jdbc:oracle:thin:ISU_SEMANTIC/fltu1632@192.168.1.2:1521/oracis -m ../mappings/all.sml | tee ../data/itmo.nt
