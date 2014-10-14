package DDG::Spice::Candidates;
# ABSTRACT: Return Candidates for given state, given year, given district.

use DDG::Spice;

primary_example_queries "new york district 1 candidates 2014";
secondary_example_queries "florida district 2 canidates 2012", "2014 candidates california district 1";
description "Shows candidates by state district and year";
name "Candidates";
icon_url "/i/topics.nytimes.com.ico";
source "New York Times";
code_url "https://github.com/duckduckgo/zeroclickinfo-spice/blob/master/lib/DDG/Spice/Candidates.pm";
topics "special_interest", "trivia";
category "facts";
attribution web => ['http://www.yafun.cl','Diego Vargas'],
            email => ['duck@yafun.cl','Diego Vargas'];

spice to => 'http://api.nytimes.com/svc/elections/us/v3/finances/$1/seats/$2/$3.json?api-key={{ENV{DDG_SPICE_CANDIDATES_APIKEY}}}';

spice from => '([^/]+)/?(?:([^/]+)/?(?:([^/]+)|)|)';

spice wrap_jsonp_callback => 1;

triggers startend => 'candidates', 'election', 'elections';
sub rtrim($);

handle query_lc => sub {

    my (%states) = (
        'alabama' => 'al',
        'al' => 'al',
        'alaska' => 'ak',
        'ak' => 'ak',
        'arizona' => 'az',
        'az' => 'az',
        'arkansas' => 'ar',
        'ar' => 'ar',
        'california' => 'ca',
        'ca' => 'ca',
        'colorado' => 'co',
        'co' => 'co',
        'connecticut' => 'ct',
        'ct' => 'ct',
        'delaware' => 'de',
        'de' => 'de',
        'florida' => 'fl',
        'fl' => 'fl',
        'georgia' => 'ga',
        'ga' => 'ga',
        'hawaii' => 'hi',
        'hi' => 'hi',
        'idaho' => 'id',
        'id' => 'id',
        'illinois' => 'il',
        'il' => 'il',
        'indiana' => 'in',
        'in' => 'in',
        'iowa' => 'ia',
        'ia' => 'ia',
        'kansas' => 'ks',
        'ks' => 'ks',
        'kentucky' => 'ky',
        'ky' => 'ky',
        'louisiana' => 'la',
        'la' => 'la',
        'maine' => 'me',
        'me' => 'me',
        'maryland' => 'md',
        'md' => 'md',
        'massachusetts' => 'ma',
        'ma' => 'ma',
        'michigan' => 'mi',
        'mi' => 'mi',
        'minnesota' => 'mn',
        'mn' => 'mn',
        'mississippi' => 'ms',
        'ms' => 'ms',
        'missouri' => 'mo',
        'mo' => 'mo',
        'montana' => 'mt',
        'mt' => 'mt',
        'nebraska' => 'ne',
        'ne' => 'ne',
        'nevada' => 'nv',
        'nv' => 'nv',
        'new hampshire' => 'nh',
        'nh' => 'nh',
        'new jersey' => 'nj',
        'nj' => 'nj',
        'new mexico' => 'nm',
        'nm' => 'nm',
        'new york' => 'ny',
        'ny' => 'ny',
        'north carolina' => 'nc',
        'nc' => 'nc',
        'north dakota' => 'nd',
        'nd' => 'nd',
        'ohio' => 'oh',
        'oh' => 'oh',
        'oklahoma' => 'ok',
        'ok' => 'ok',
        'oregon' => 'or',
        'or' => 'or',
        'pennsylvania' => 'pa',
        'pa' => 'pa',
        'rhode island' => 'ri',
        'ri' => 'ri',
        'south carolina' => 'sc',
        'sc' => 'sc',
        'south dakota' => 'sd',
        'sd' => 'sd',
        'tennessee' => 'tn',
        'tn' => 'tn',
        'texas' => 'tx',
        'tx' => 'tx',
        'utah' => 'ut',
        'ut' => 'ut',
        'vermont' => 'vt',
        'vt' => 'vt',
        'virginia' => 'va',
        'va' => 'va',
        'washington' => 'wa',
        'wa' => 'wa',
        'west virginia' => 'wv',
        'wv' => 'wv',
        'wisconsin' => 'wi',
        'wi' => 'wi',
        'wyoming' => 'wy',
        'wy' => 'wy'
    );

    # Matches against special variable `$_`, which contains query
    my ($state1, $state2) = /^(.*)(?:\s)*(election|elections|candidate|candidates)(?:\s)*(.*)$/g;

    my ($state);

    # Regex returns a space after $1, so we must remove it before hashing
    $state1 = rtrim($state1);

    if (exists $states{$state1}) {
        $state = $states{$state1};
    } elsif (exists $states{$state2}) {
        $state = $states{$state2};
    } else {
        return;
    }

    return $state if ($state);
    return;
};

1;

sub rtrim($) {
    # Removes trailing whitespace
    my $string = shift;
    $string =~ s/\s+$//;
    return $string;
}
