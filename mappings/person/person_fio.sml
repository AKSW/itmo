PREFIX ifmolod:<http://lod.ifmo.ru/>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

CREATE VIEW Staff AS CONSTRUCT {
   ?person a foaf:Person ;
               vivoplus:pcardId ?pcardId;
               foaf:firstName ?firstName;
               vivo:middleName ?middleName;
               foaf:lastName ?lastName;
               rdfs:label ?label;
               vivo:affiliatedOrganization ?laboratory;
               a ?supervisorType.

}
WITH
  ?person = uri(concat("http://lod.ifmo.ru/Person", ?PCARD_ID))
  ?pcardId = typedLiteral(?PCARD_ID,xsd:positiveInteger)
  ?firstName = plainLiteral(?FIRST_NAME, 'ru')
  ?middleName = plainLiteral(?PATRONYMIC, 'ru')
  ?lastName = plainLiteral(?LAST_NAME, 'ru')
  ?label = plainLiteral(concat(concat(?FIRST_NAME," "),?LAST_NAME))
  ?laboratory = uri(ifmolod:,"Laboratory",?NET_DEP_ID)
  ?supervisorType = uri(vivoplus:,?SUPERVISOR_TYPE)
FROM
  [[SELECT NET_DEP_ID, PCARD_ID,FIRST_NAME, PATRONYMIC, LAST_NAME, 
   replace(replace(RANG_BOSS,'Научный_руководитель','ScientificSupervisor'),'Руководитель','Supervisor') SUPERVISOR_TYPE
  FROM sem_person_fio]]
