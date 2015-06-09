PREFIX ifmolod:<http://lod.ifmo.ru/>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

CREATE VIEW SemResultPerson AS CONSTRUCT {
  ?person a foaf:Person ;
              vivoplus:pcardId ?pcardId;
              rdfs:label ?rsltId

}
WITH
  ?person = uri(concat("http://lod.ifmo.ru/Person", ?PCARD_ID))
  ?pcardId = typedLiteral(?PCARD_ID,xsd:positiveInteger)
  ?rsltId = plainLiteral(?RSLT_ID)
FROM
  [[SELECT * FROM sem_result_person]]
