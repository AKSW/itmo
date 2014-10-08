PREFIX lod-ifmo:<http://lod.ifmo.ru>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>

CREATE VIEW LaboratoryResearchFields AS CONSTRUCT {
  ?laboratory vivoplus:hasResearchArea ?researchArea .
}
WITH
  ?laboratory = uri(concat("http://lod.ifmo.ru/Laboratory/", ?NET_DEP_ID))
  ?researchArea = uri(concat("http://lod.ifmo.ru/ResearchArea/", ?RES_DIR))
FROM
  [[ SELECT NET_DEP_ID, regexp_substr(trim((regexp_substr (RES_DIR, '[^|]+', 1, level))), '\d+') RES_DIR 
     FROM SEM_LIST_INFO 
     CONNECT BY level <= length (regexp_replace (RES_DIR, '[^|]+')) + 1]]
