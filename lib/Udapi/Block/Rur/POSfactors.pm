package Udapi::Block::Rur::POSfactors;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

has_ro dir => ( isa=>Bool, default => 0 );

sub process_node {
    my ($self, $node) = @_;

    my $prev_upos = "BOS";
    if ($node->ord > 1) {
        $prev_upos = $node->prev_node()->upos;
    }

    my $next_upos = "EOS";
    if (defined $node->next_node()) {
        $next_upos = $node->next_node()->upos;
    }

    if ($self->dir) {
        $prev_upos = $prev_upos . '-';
        $next_upos = $next_upos . '+';
    }

    print $node->form . "\t" . $prev_upos . "\n";
    print $node->form . "\t" . $next_upos . "\n";

    return ;
}

1;

__END__

=head1 DESCRIPTION


