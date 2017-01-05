package Udapi::Block::Rur::DeAccent;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

use Text::Unidecode;

sub process_node {
    my ($self, $node) = @_;

    my $form = unidecode($node->form);
    $node->set_form($form);

    return;
}

1;

__END__

=head1 DESCRIPTION

Remove accents from form

