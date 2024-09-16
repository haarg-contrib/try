#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use 5.014;

use Try;

my ( $error, $topic );

my $last_did_not_exit_loop;

for ("foo") {
    try {
        die "blah\n";
    } catch {
        is \$_, \$_[0], "topic is an alias";
        $topic = $_;
        $error = $_[0];
        no warnings;
        last;
    }
    pass("syntax ok");
    $last_did_not_exit_loop = 1;
    is $_, "foo", '$_ not clobbered';
}

ok $last_did_not_exit_loop, 'implicit loop inside catch';

is( $error, "blah\n", "error caught" );

{
    local $TODO = "perhaps a workaround can be found";
    is( $topic, $error, 'error is also in $_' );
}

done_testing;
