#!/usr/bin/env python

from SPARQLWrapper import SPARQLWrapper
from SPARQLWrapper import JSON

import codecs

outputFile = codecs.open("lgdLabels.nt", "w", "utf-8")
lgdList = list(set([line.rstrip() for line in open('lgd.list')]))
rdfsLabel = "http://www.w3.org/2000/01/rdf-schema#label"
countryCodePropertyFips = "http://linkedgeodata.org/ontology/country_code_fips"
countryCodePropertyIso = "http://linkedgeodata.org/ontology/country_code_iso3166_1_alpha_2"
countryCodeProperty = "http://linkedgeodata.org/ontology/country_code_iso3166"

sparql = SPARQLWrapper("http://linkedgeodata.org/sparql")
for lgdEntity in lgdList:
    print lgdEntity
    sparql.setQuery("""
        SELECT ?label_en
        WHERE {
            <%s> rdfs:label ?label_en .
            FILTER(LANG(?label_en) = "en")
        }
    """ % (lgdEntity,))

    sparql.setReturnFormat(JSON)
    results = sparql.query().convert()
    labelEn = results['results']['bindings'][0]['label_en']['value']

    sparql.setQuery("""
        SELECT ?label_ru
        WHERE {
            <%s> rdfs:label ?label_ru .
            FILTER(LANG(?label_ru) = "ru")
        }
    """ % (lgdEntity,))
    results = sparql.query().convert()
    labelRu = results['results']['bindings'][0]['label_ru']['value']

    sparql.setQuery("""
        SELECT ?country_code_fips ?country_code_iso
        WHERE {
            <%s> ?p ?o .
            OPTIONAL {<%s> <%s> ?country_code_fips .}
            OPTIONAL {<%s> <%s> ?country_code_iso .}
        }
    """ % (lgdEntity, lgdEntity, countryCodePropertyFips, lgdEntity, countryCodePropertyIso))
    results = sparql.query().convert()
    try: 
        countryCode = results['results']['bindings'][0]['country_code_iso']['value']
    except:
        countryCode = results['results']['bindings'][0]['country_code_fips']['value']

    outputFile.write(u'<%s> <%s> "%s"@en .\n' % (lgdEntity, rdfsLabel, labelEn))
    outputFile.write(u'<%s> <%s> "%s"@ru .\n' % (lgdEntity, rdfsLabel, labelRu))
    outputFile.write(u'<%s> <%s> "%s" .\n' % (lgdEntity, countryCodeProperty, countryCode))

#For DBpedia needs another endpoint
dbpediaEntity = "http://dbpedia.org/resource/Portugal"

sparql = SPARQLWrapper("http://dbpedia.org/sparql")
sparql.setQuery("""
    SELECT ?label_en
    WHERE {
        <%s> rdfs:label ?label_en .
        FILTER(LANG(?label_en) = "en")
    }
""" % (dbpediaEntity,))

sparql.setReturnFormat(JSON)
results = sparql.query().convert()
labelEn = results['results']['bindings'][0]['label_en']['value']

sparql.setQuery("""
    SELECT ?label_ru
    WHERE {
        <%s> rdfs:label ?label_ru .
        FILTER(LANG(?label_ru) = "ru")
    }
""" % (dbpediaEntity,))
results = sparql.query().convert()
labelRu = results['results']['bindings'][0]['label_ru']['value']

outputFile.write(u'<%s> <%s> "%s"@en .\n' % (dbpediaEntity, rdfsLabel, labelEn))
outputFile.write(u'<%s> <%s> "%s"@ru .\n' % (dbpediaEntity, rdfsLabel, labelRu))
outputFile.write(u'<%s> <%s> "PT" .\n' % (lgdEntity, countryCodeProperty))

outputFile.close()
