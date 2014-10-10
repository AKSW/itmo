PREFIX lod-ifmo:<http://lod.ifmo.ru>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

CREATE VIEW Staff AS CONSTRUCT {
   ?person a foaf:Person ;
               vivoplus:academicStatus ?academicStatus. // align to existing vocabulary

}
WITH
  ?person = uri(concat("http://lod.ifmo.ru/Person", ?PCARD_ID))
  ?academicStatus= uri(concat("http://vivoplus.aksw.org/ontology#",
  ?ACADEMIC_STATUS))
FROM
  [[SELECT PCARD_ID, ACADEMIC_STATUS FROM sem_person_academic_status]]
