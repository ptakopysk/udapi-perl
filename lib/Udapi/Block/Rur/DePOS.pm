package Udapi::Block::Rur::DePOS;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

sub process_node {
    my ($self, $node) = @_;

    $node->set_upos('_');
    $node->set_feats('_');

    return;
}

1;

__END__

=head1 DESCRIPTION

Set upos and feats to '_'.

