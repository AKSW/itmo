PREFIX ifmolod:<http://lod.ifmo.ru/>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

CREATE VIEW AcademicDegree AS CONSTRUCT {
   ?person a foaf:Person ;
               vivoplus:pcardId ?pcardId;
               vivoplus:academicQualification ?qualification;
               vivoplus:degreeLevel ?level; // align to existing vocabulary
               vivoplus:degreeSubject ?subject. // align

   ?qualification a vivoplus:AcademicQualification;
	rdfs:label ?qualificationLabel;
	rdfs:label ?qualificationLabelRu;
	vivoplus:academicDegree ?degree;
	vivoplus:academicSubject ?subject.

   ?degree a vivo:AcademicDegree;
	rdfs:label ?degreeLabel;
	rdfs:label ?degreeLabelRu.

   ?subject a vivoplus:AcademicSubject;
	rdfs:label ?subjectLabel;
	rdfs:label ?subjectLabelRu.

}
WITH
  ?pcardId = typedLiteral(?PCARD_ID,xsd:positiveInteger)
  ?person = uri(ifmolod:,"Person", ?PCARD_ID)
  ?qualification = uri(ifmolod:,?DEGREE,"In",?SUBJECT_CAMEL)
  ?degree  = uri(vivoplus:,?DEGREE)
  
# assumes that it does not shadow other uris, if it does then append "Subject"
  ?subject = uri(ifmolod:,?SUBJECT_CAMEL)

  ?qualificationLabel = plainLiteral(?ACADEMIC_DEGREE_TRANS)
  ?qualificationLabelRu = plainLiteral(?ACADEMIC_DEGREE,"ru")
  
  ?degreeLabel = plainLiteral(?DEGREE_LABEL_TRANS)
  ?degreeLabelRu = plainLiteral(?DEGREE_LABEL_RU,"ru")

  ?subjectLabel = plainLiteral(?SUBJECT_TRANS)
  ?subjectLabelRu = plainLiteral(?SUBJECT_RU,"ru")
FROM
  [[select PCARD_ID,

   replace(replace(replace(
   REGEXP_SUBSTR(ACADEMIC_DEGREE,'\w*'),
   'кандидат','CandidateOfSciences'),
   'доктор','DoctorOfSciences'),
   'PhD','CandidateOfSciences
   ') DEGREE,

trans_eng(REGEXP_SUBSTR(ACADEMIC_DEGREE,'\w*')) DEGREE_LABEL_TRANS,
REGEXP_SUBSTR(ACADEMIC_DEGREE,'\w*') DEGREE_LABEL_RU,

trans_eng(ACADEMIC_DEGREE) ACADEMIC_DEGREE_TRANS,
ACADEMIC_DEGREE,
trim(REGEXP_SUBSTR(ACADEMIC_DEGREE,'\w*[ ,]*(.*)',1,1,NULL,1)) SUBJECT_RU,

trans_eng(trim(REGEXP_SUBSTR(ACADEMIC_DEGREE,'\w*[ ,]*(.*)',1,1,NULL,1)))
SUBJECT_TRANS,

regexp_replace(initcap(regexp_replace(
trans_eng(trim(replace(REGEXP_SUBSTR(ACADEMIC_DEGREE,'\w*[
,]*(.*)',1,1,NULL,1),'-',' '))),
 '[[:digit:]]', ' ')), '([[:punct:] | [:blank:]])', '')
 SUBJECT_CAMEL

from sem_person_academic_degree where ACADEMIC_DEGREE is not null]]
