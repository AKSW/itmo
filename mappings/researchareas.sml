PREFIX lod-ifmo:<http://lod.ifmo.ru>
PREFIX vivoplus:<http://vivoplus.aksw.org/ontology#>
PREFIX vivo:<http://vivoweb.org/ontology/core#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd:<http://www.w3.org/2001/XMLSchema#>

CREATE VIEW LaboratoryResearchFields AS CONSTRUCT {
  ?researchArea a vivoplus:ResearchArea;
                rdfs:label ?label.
}
WITH
  ?researchArea = uri(concat("http://lod.ifmo.ru/ResearchArea/", ?RES_DIR_ID))
  ?label = typedLiteral(?RES_DIR, xsd:string)
FROM
  [[ SELECT
     sm.atrb_id AS "RES_DIR_ID", 
     sm.text_value AS "RES_DIR"
     FROM isu_spm.sem_res_dir_info sm]]
