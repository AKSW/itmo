#!/bin/bash

REPOSITORY=$(dirname $PWD)

echo "java -cp \"/home/ivan/Repositories/projects/itmo/lib/ojdbc6.jar:/home/ivan/Repositories/projects/itmo/lib/sparqlify-core-0.6.13-SNAPSHOT-jar-with-dependencies.jar\" org.aksw.sparqlify.web.Main \"\$@\"" > /usr/bin/sparqlify
