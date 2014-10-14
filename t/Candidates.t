#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Spice;

ddg_spice_test(
    [qw( DDG::Spice::Candidates )],
    '1 ny 2014 candidates' => test_spice(
        '/js/spice/candidates/2014/ny/1',
        call_type => 'include',
        caller => 'DDG::Spice::Candidates'
    ),
    'new york 1 candidates 2014' => test_spice(
        '/js/spice/candidates/2014/ny/1',
        caller => 'DDG::Spice::Candidates',
    ),
    'missouri 2014 candidates district 2' => test_spice(
        '/js/spice/candidates/2014/mo/2',
        caller => 'DDG::Spice::Candidates',
    ),
    '2014 california candidates district 1' => test_spice(
        '/js/spice/candidates/2014/ca/1',
        caller => 'DDG::Spice::Candidates',
    ),
);

done_testing;
