PREFIX lod-ifmo:<http://lod.ifmo.ru>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd:<http://www.w3.org/2001/XMLSchema#>

CREATE VIEW LaboratoryResearchFields AS CONSTRUCT {
  ?laboratory vivoplus:locatedIn ?country .
}
WITH
  ?laboratory = uri(concat("http://lod.ifmo.ru/Laboratory", ?NET_DEP_ID))
  ?country = uri(?URI)
FROM
  [[ SELECT 
       NET_DEP_ID,
       URI 
     FROM sem_country_info, sem_country_lgd
     WHERE 
       country_id=id
  ]]
