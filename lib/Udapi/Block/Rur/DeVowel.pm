package Udapi::Block::Rur::DeVowel;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

use Text::Unidecode;

sub process_node {
    my ($self, $node) = @_;

    my $form = $node->form;
    $form =~ s/æ/ae/gi;
    my $form_nodia = unidecode($form);
    if ($form_nodia =~ /[aeiouy]/i) {
        if (length($form) eq length($form_nodia)) {
            my $new_form = '';
            for (my $i = 0; $i < length($form); $i++) {
                if (substr($form_nodia, $i, 1) !~ /[aeiouy]/i) {
                    $new_form .= substr($form, $i, 1);
                }
            }
            if ($new_form eq '') {
                $new_form = '_';
            }
            $node->set_form($new_form);
        } else {
            warn "Cannot devowel '$form', bacause deaccented '$form_nodia' has different length\n";
        }
    }

    return;
}

1;

__END__

=head1 DESCRIPTION

Remove vowels from form

Internally uses the deaccented version of form, and does nothing if the length of the deaccented form is different than that of the original form.

