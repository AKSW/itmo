PREFIX lod-ifmo:<http://lod.ifmo.ru>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>

CREATE VIEW Laboratories AS CONSTRUCT {
   ?laboratory a vivoplus:Laboratory ;
               a vivo:Laboratory;
               rdfs:label ?name.
}
WITH
  ?laboratory = uri(concat("http://lod.ifmo.ru/", ?NET_DEP_ID))
  ?name = plainLiteral(?NAME)
FROM
  [[SELECT NET_DEP_ID, NAME FROM sem_list_info]]
