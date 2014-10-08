PREFIX lod-ifmo:<http://lod.ifmo.ru>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

CREATE VIEW Staff AS CONSTRUCT {
   ?person a foaf:Person ;
               a vivo:Laboratory;
               foaf:firstName ?firstName;
               foaf:lastName ?lastName;
               vivo:middleName ?middleName;
               vivoplus:isBoss ?isBoss;
               vivoplus:pcardId ?pcardId;
               vivo:affiliatedOrganization ?laboratory;
               rdfs:label ?label.

}
WITH
  ?person = uri(concat("http://lod.ifmo.ru/Person", ?PCARD_ID))
  ?pcardId = typedLiteral(?PCARD_ID,xsd:positiveInteger)
  ?firstName = plainLiteral(?FIRST_NAME, 'ru')
  ?middleName = plainLiteral(?PATRONYMIC, 'ru')
  ?lastName = plainLiteral(?LAST_NAME, 'ru')
  ?laboratory = uri(concat("http://lod.ifmo.ru/Laboratory",?NET_DEP_ID))
  ?label = plainLiteral(concat(concat(?FIRST_NAME," "),?LAST_NAME))
  ?isBoss = typedLiteral(?IS_BOSS,xsd:boolean)
FROM
  [[SELECT NET_DEP_ID, PCARD_ID,FIRST_NAME, PATRONYMIC, LAST_NAME, USRS_STATUS,
  replace(replace(USRS_STATUS,'BOSS','true'),'USER','false') IS_BOSS FROM
  sem_person_info]]
