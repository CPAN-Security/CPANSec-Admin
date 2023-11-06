use v5.38;
use Test2::V0;

plan 3;

use CPANSec::Admin;
pass 'CPANSec::Admin loaded successfully';

ok my $app = CPANSec::Admin->new, 'able to instantiate';
can_ok $app, 'run';
