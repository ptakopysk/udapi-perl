package Udapi::Block::Rur::POSfactors;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

has_ro dir => ( isa=>Bool, default => 0 );
has_ro num => ( isa=>Bool, default => 0 );
has cs => ( is=>'rw', default => 1 );

sub print_word {
    my ($self, $form, $position, $node) = @_;

    my $upos;
    if (!defined $node) {
        $upos = 'EOS';
    } elsif ($node->ord == 0) {
        $upos = 'BOS';
    } else {
        $upos = $node->upos;
    }

    if ($self->dir) {
        $upos .= ($position > 0 ? '+' : '-');
    }

    if ($self->num) {
        $upos .= abs($position);
    }

    print $form . "\t" . $upos . "\n";

    return ;
}

sub process_node {
    my ($self, $node) = @_;

    my $form = $node->form;

    my $prev_node = $node->prev_node();
    for (my $position = -1; $position >= -$self->cs; $position--) {
        $self->print_word($form, $position, $prev_node);
        if ($prev_node->ord == 0) {
            last;
        } else {
            $prev_node = $prev_node->prev_node();
        }
    }
    
    my $next_node = $node->next_node();
    for (my $position = 1; $position <= $self->cs; $position++) {
        $self->print_word($form, $position, $next_node);
        if (!defined $next_node) {
            last;
        } else {
            $next_node = $next_node->next_node();
        }
    }

    return ;
}

1;

__END__

=head1 DESCRIPTION


