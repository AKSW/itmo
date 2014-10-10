PREFIX lod-ifmo:<http://lod.ifmo.ru>
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
               vivo:affiliatedOrganization ?subDepartment;
               vivoplus:jobType ?jobType;
               vivoplus:academicStatus ?academicStatus;
               rdfs:comment ?postFormat.

}
WITH
  ?person = uri(concat("http://lod.ifmo.ru/Person", ?PCARD_ID))
  ?pcardId = typedLiteral(?PCARD_ID,xsd:positiveInteger)
  ?firstName = plainLiteral(?FIRST_NAME, 'ru')
  ?middleName = plainLiteral(?PATRONYMIC, 'ru')
  ?lastName = plainLiteral(?LAST_NAME, 'ru')
  ?label = plainLiteral(concat(concat(?FIRST_NAME," "),?LAST_NAME))
  ?laboratory = uri(vivoplus:,"Laboratory",?NET_DEP_ID)
  ?subDepartment = uri(vivoplus:,"/Subdepartment",?SUB_DEPARTMENT)
  ?jobType = uri(vivoplus:,?JOB_TYPE) # TODO transliterate, remove spaces
 ?postFormat = plainLiteral(?POST_FORMAT,'ru')
FROM
  [[SELECT NET_DEP_ID, PCARD_ID,FIRST_NAME, PATRONYMIC, LAST_NAME, 
   regexp_replace(initcap(regexp_replace(SUB_DEPARTMENT, '[[:digit:]]', ' ')),
   '([[:punct:] | [:blank:]])', ''), JOB_TYPE, POST_FORMAT
  FROM sem_person_fio]]
