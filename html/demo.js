$(document).ready(
    function (){
        function generateSgvizler(sparqlQuery) {
          var divElement = "<div ";       
          divElement += "id='sgvizler' "; 
          divElement += "data-sgvizler-endpoint='http://lod.ifmo.ru/sparql' ";
          divElement += "data-sgvizler-query='"+sparqlQuery+"' ";
          divElement += "data-sgvizler-chart='google.visualization.GeoChart' ";
          divElement += "data-sgvizler-loglevel='5' ";
          divElement += "style='width:99%; height:99%;'>";
          divElement += "</div>";         
          return divElement;
        }
        function visualizeDiv(divElement) {
          var vizContainer = document.getElementById('sgvizler-container');//.appendChild(divElement);
          vizContainer.innerHTML = divElement;
          sgvizler.containerDrawAll();    
          $("#sgvizler-container").show();
        }
        function showPersons(laboratoryUri) {
          var sparqlQuery = "select ?person ?label {?person rdfs:label ?label. ?person a foaf:Person. ?person vivo:affiliatedOrganization <"+laboratoryUri+">.}";
          var sparqlEndpoint = "http://lod.ifmo.ru/sparql";
          var queryUrl = sparqlEndpoint+"?query="+ encodeURIComponent(sparqlQuery) +"&format=json";
          $.ajax({
              dataType: "jsonp",  
              url: queryUrl,
              success: function( _data ) { 
                var persons = _data.results.bindings;
                $("#persons-list").html("");
                for ( var i in persons ) {
                    var personUri = persons[i].person.value;
                    var personLabel = persons[i].label.value;
                    $("#persons-list").append("<li><a href=\""+personUri+"\">About</a><a href=\"#\" >"+personLabel+"</a></li>");
                }
                $("#persons-list-container").show();
              }
          });
        }

        sgvizler
          .defaultEndpointOutputFormat('json')
          .containerDrawAll();

          $("#laboratories-show-all").on("click", function() {
            var sparqlQuery = "select ?country count(?lab) as ?Laboratories {?lab a vivo:Laboratory. ?lab vivoplus:locatedIn ?c. ?c rdfs:label ?country}";
            visualizeDiv(generateSgvizler(sparqlQuery));
            $("#laboratories-show-all").hide();
            $("#laboratories-list-container").hide();
            $("#persons-list-container").hide();
          });

          $(document).on("regionClick", function(event, data){
            console.log(data);
            queryCountry(data);
          });

          function queryCountry(data) {
            var sparqlEndpoint = "http://lod.ifmo.ru/sparql";
            var query = [
              "SELECT ?lab ?labLabel", 
              "WHERE {",
                "?lab vivoplus:locatedIn ?country.",
                "?lab rdfs:label ?labLabel.",
                "?country lgdo:country_code_iso3166 \""+data.region+"\".",
              "}"
             ].join(" "); 
            var queryUrl = sparqlEndpoint+"?query="+ encodeURIComponent(query) +"&format=json";
            $.ajax({
                dataType: "jsonp",  
                url: queryUrl,
                success: function( _data ) {
                    var laboratories = _data.results.bindings;
                    $("#laboratories-list").html("");
                    for ( var i in laboratories ) {
                        var laboratoryUri = laboratories[i].lab.value;
                        var laboratoryLabel = laboratories[i].labLabel.value;
                        $("#laboratories-list").append("<li><a href=\""+laboratoryUri+"\">About</a><a href=\"#\" data-laboratoryUri=\""+laboratoryUri+"\" class=\"laboratory\">"+laboratoryLabel+"</a></li>");
                    }
                    $(".laboratory").off();
                    $(".laboratory").on("click", function(event) {
                      var laboratoryUri = event.target.getAttribute('data-laboratoryUri');
                      //$("#laboratories-list-container").hide();
                      //var sparqlQuery = this.constructSparqlQuerySgvizler(this.similarResourcesIds, this.mappingName);
                      var sparqlQuery = "select ?country count(1) as ?Laboratories {<"+laboratoryUri+"> a vivo:Laboratory. <"+laboratoryUri+"> vivoplus:locatedIn ?c. ?c rdfs:label ?country}";
                      var divElement = generateSgvizler(sparqlQuery);
                      visualizeDiv(divElement);
                      $("#laboratories-show-all").show();
                      showPersons(laboratoryUri);
                    });
                    $("#laboratories-list-container").show();
                }
            });
          };
    }
);

jQuery.extend(
    {
        loadStyleSheet: function(file, type) {
            $('<link>').attr('rel', 'stylesheet')
                .attr('type', type)
                .attr('href', file)
                .appendTo('head');
        }
    }
);
