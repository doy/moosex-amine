#! perl

use Test::More;

use MooseX::amine;
use lib './t/lib';

my $mex = MooseX::amine->new( 'Test::Inheritance::ObjectWithRole' );

isa_ok( $mex , 'MooseX::amine' );
isa_ok( $mex->metaobj , 'Moose::Meta::Class' );

my $expected_data_structure = {
  attrs   => {
    base_attribute   => {
      from   => 'Test::Inheritance::Base',
      meta   => { constraint => 'Str' },
      reader => 'base_attribute'
    },
    string_attribute => {
      accessor => 'string_attribute',
      from     => 'Test::Inheritance::ObjectWithRole',
      meta     => { constraint => 'Str' }
    },
    role_attribute => {
      accessor => 'role_attribute',
      from     => 'Test::Basic::Role',
      meta     => {
        constraint    => 'Str' ,
        is_required   => 1 ,
        documentation => 'required string' ,
      } ,
    } ,
  },
  methods => {
    base_method => { from => 'Test::Inheritance::Base' },
    test_method => { from => 'Test::Inheritance::ObjectWithRole' } ,
    role_method => { from => 'Test::Basic::Role' } ,
  }
};
is_deeply( $mex->examine , $expected_data_structure , 'see expected output from examine()' );

done_testing();