package Udapi::Block::Rur::Delexicalize;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

sub process_node {
    my ($self, $node) = @_;

    $node->set_form('_');
    $node->set_lemma('_');

    return;
}

1;

__END__

=head1 DESCRIPTION

Set form and lemma to '_'.

