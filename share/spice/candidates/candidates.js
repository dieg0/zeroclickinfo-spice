(function(env) {
    "use strict";

    env.ddg_spice_candidates = function(api_result) {

        if (!api_result || !api_result.results || api_result.results.length === 0) {
            return Spice.failed("candidates");
        }

        var state = api_result.results[0].state_name,
            state_code = api_result.results[0].state,
            district = api_result.results[0].district;
            year = api_result.results[0].year;

        var itemType;

            itemType =  state + ' District ' + district + ' Candidates for ' + year + 'Elections';


        Spice.add({
            id: 'candidate',
            name: 'Candidates',
            data: api_result.results,
            meta: {
                sourceName: 'nytimes.com',
                sourceUrl: "http://api.nytimes.com/svc/elections/us/v3/finances/" + year + "/seats/" + state_code + "/" + district + ".json",
                itemType: itemType
            },
            normalize: function(item) {

                var name = (item.name ? item.name : '');

                var party;

                switch(item.party){
                    case "DEM":
                        party = "Democratic";
                        break;
                    case "REP":
                        party = "Republican";
                        break;
                    case "IND":
                        party = "Independent";
                        break;
                }

                return {
                    url: "http://docquery.fec.gov/cgi-bin/fecimg/?" + item.id,
                    heading: name,
                    title: name,
                    party: party
                };
            },
            templates: {
                group: 'products',
                options: {
                    buy: Spice.candidates.buy,
                    rating: false,
                    variant: 'narrow',
		    price: false,
		    brand: false
                }
            }
        });
    };
}(this));


/*******************************
Handlebars helpers
*******************************/

// Creates a full name for a given representative
Handlebars.registerHelper ('candidates_get_name', function(name) {
    "use strict";
    return (name ? name : '');
});

