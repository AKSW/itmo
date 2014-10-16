#!/bin/bash

#sparqlify -D -U ISU_SEMANTIC -W fltu1632 -j jdbc:oracle:thin:ISU_SEMANTIC/fltu1632@192.168.134.3:1521/oracis -m ../mappings/$1/$2.sml
sparqlify -D -U ISU_SEMANTIC -W fltu1632 -j jdbc:oracle:thin:ISU_SEMANTIC/fltu1632@194.85.163.158:1521/oracis -m ../mappings/$1/$2.sml
