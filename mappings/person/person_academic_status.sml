PREFIX ifmolod:<http://lod.ifmo.ru/>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

CREATE VIEW Staff AS CONSTRUCT {
   ?person a foaf:Person ;
   vivoplus:academicStatus ?academicStatus. // todo: align to existing vocabulary

}
WITH
  ?person = uri(ifmolod:,"Person",?PCARD_ID)
  ?academicStatus= uri(vivoplus:,?ACADEMIC_STATUS_CAMEL)
FROM
  [[SELECT PCARD_ID,
regexp_replace(initcap(regexp_replace(
trans_eng(trim(ACADEMIC_STATUS)),
'[0-9]', ' ')), '[-|[:space:]|-|[:punct:]|-]', '') ACADEMIC_STATUS_CAMEL
FROM sem_person_academic_status]]
