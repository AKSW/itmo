PREFIX ifmolod:<http://lod.ifmo.ru/>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

CREATE VIEW Person_Study_Status_Student AS CONSTRUCT {
   ?person a foaf:Person ;
            a vivo:Student.

}
WITH
  ?person = uri(concat("http://lod.ifmo.ru/Person", ?PCARD_ID))
FROM
  [[SELECT PCARD_ID, ANGL
  FROM sem_person_study_status
WHERE ANGL='студент']]


CREATE VIEW Person_Study_Status_Doctorand AS CONSTRUCT {
   ?person a foaf:Person ;
            a ?doctorandType. 
}
WITH
  ?person = uri(vivoplus:,"Person", ?PCARD_ID)
  ?doctorandType = uri(vivoplus:,?DOCTORAND_TYPE,"OfSciences")
FROM
  [[SELECT PCARD_ID,
  replace(replace(ANGL,'докторант','Doctor'),'аспирант','Candidate') DOCTORAND_TYPE
  FROM sem_person_study_status
WHERE ANGL='аспирант' OR ANGL='докторант']]
