PREFIX lod-ifmo:<http://lod.ifmo.ru>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>

CREATE VIEW LaboratoryResearchFields AS CONSTRUCT {
  ?laboratory vivoplus:hasResearchArea ?researchArea .
}
WITH
  ?laboratory = uri(concat("http://lod.ifmo.ru/Laboratory/", ?NET_DEP_ID))
  ?country = uri(concat("http://lod.ifmo.ru/ResearchArea/", ?RES_DIR_ID))
FROM
  [[ SELECT
     sm.atrb_id AS "RES_DIR_ID", 
     sm.net_dep_id AS "NET_DEP_ID" 
     FROM isu_spm.sem_res_dir_info sm]]
