package Udapi::Block::Rur::DeAccentDeVowel;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

use Text::Unidecode;

sub process_node {
    my ($self, $node) = @_;

    my $form = unidecode($node->form);
    $form =~ s/[aeiouy]//gi;
    $node->set_form($form);

    return;
}

1;

__END__

=head1 DESCRIPTION

Remove accents and vowels from form

