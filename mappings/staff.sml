PREFIX lod-ifmo:<http://lod.ifmo.ru>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

CREATE VIEW Staff AS CONSTRUCT {
   ?person a foaf:Person ;
               a vivo:Laboratory;
               foaf:firstName ?firstName;
               foaf:lastName ?lastName;
               vivo:middleName ?middleName;
               rdfs:label ?label.

}
WITH
  ?laboratory = uri(concat("http://lod.ifmo.ru/Laboratory/", ?NET_DEP_ID))
  ?name = typedLiteral(?NAME, xsd:String)
FROM
  [[SELECT NET_DEP_ID, NAME FROM sem_list_info]]
