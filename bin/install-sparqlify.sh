#!/bin/bash

REPOSITORY=$(dirname $PWD)

echo "java -Xmx4196m -Duser.country=ru -Duser.language=ru -cp \"$REPOSITORY/lib/ojdbc6.jar:$REPOSITORY/lib/sparqlify-core-0.6.13-SNAPSHOT-jar-with-dependencies.jar\" org.aksw.sparqlify.web.Main \"\$@\"" > /usr/bin/sparqlify
chmod +x /usr/bin/sparqlify
