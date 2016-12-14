package Udapi::Block::Rur::DePOS;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

sub process_node {
    my ($self, $node) = @_;


    if ($node->upos =~ /-$/) {
        # prefix, e.g. upos = VERB-
        $node->set_upos('_-');
    } elsif ($node->upos =~ /^-/) {
        # suffix, e.g. upos = -VERB
        $node->set_upos('-_');
    } else {
        $node->set_upos('_');
    }
    $node->set_feats('_');

    return;
}

1;

__END__

=head1 DESCRIPTION

Set upos and feats to '_'.

If upos is pre/suf marked, also uses '_-' for prefixes and '-_' for suffixes.

