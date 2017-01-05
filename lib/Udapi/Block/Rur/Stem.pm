package Udapi::Block::Rur::Stem;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

has n => ( is => 'rw', default => 3 );

sub process_node {
    my ($self, $node) = @_;

    my $form = $node->form // '_';
    $form = substr $form, 0, $self->n;
    $node->set_form($form);

    return;
}

1;

__END__

=head1 DESCRIPTION

Make form only C<n> characters long, by clipping the ending.
By default C<n=3>.

