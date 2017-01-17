package Udapi::Block::Rur::Stem;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

has n => ( is => 'rw', default => 3 );
has on => ( is => 'rw', default => 'form' );

sub process_node {
    my ($self, $node) = @_;

    my $form = ($self->on eq 'form' ? $node->form : $node->lemma) // '_'  ;
    $form = substr $form, 0, $self->n;
    if ( $self->on eq 'form') {
        $node->set_form($form);
    } else {
        $node->set_lemma($form);
 }

    return;
}

1;

__END__

=head1 DESCRIPTION

Make form only C<n> characters long, by clipping the ending.
By default C<n=3>.

