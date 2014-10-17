PREFIX ifmolod:<http://lod.ifmo.ru/>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd:<http://www.w3.org/2001/XMLSchema#>

CREATE VIEW Laboratories AS CONSTRUCT {
   ?laboratory rdfs:label ?name.
}
WITH
  ?laboratory = uri(ifmolod:,"Laboratory", ?NET_DEP_ID)
  ?name = plainLiteral(?NAME, 'en')
FROM
  [[SELECT NET_DEP_ID, NAME FROM sem_list_info WHERE LANG='Английский']]
