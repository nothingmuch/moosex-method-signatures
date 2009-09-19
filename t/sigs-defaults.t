use strict;
use warnings;
use Test::More tests => 8;

{
    package Defaults;
    use MooseX::Method::Signatures;

    method pos ($arg = "pos default") { $arg }

    method named (:$arg = 42) { $arg }

    method foo { "foo" }
    method method_call (:$arg = $self->foo ) { $arg }
    method bracketed_method_call (:$arg = { $self->foo } ) { $arg }
}

my $d = Defaults->new;

is( $d->pos, "pos default" );
is( $d->pos("blech"), "blech" );

is( $d->named, 42 );
is( $d->named( arg => "lala" ), "lala" );

is( $d->foo, "foo" );

is( $d->method_call, "foo" );
is( $d->bracketed_method_call, "foo" );
is( $d->method_call( arg => "override" ), "override" );

