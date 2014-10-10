#!/bin/bash

sparqlify -D -U ISU_SEMANTIC -W fltu1632 -j jdbc:oracle:thin:ISU_SEMANTIC/fltu1632@194.85.163.21:1521/oracis -m ../mappings/$1.sml
