package Udapi::Block::Rur::SplitForms;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

has_ro dePOS => ( isa=>Bool, default => 0 );

sub process_node {
    my ($self, $node) = @_;

    if ($self->dePOS) {
        $node->set_upos('_');
    }

    if ($node->form =~ / /) {
        my @forms = split / /, $node->form;
        my $last_suffix = $node;  # after which node to put a new suffix
        foreach my $form (@forms) {
            if ($form =~ /-$/) {
                # prefix, e.g. před-
                my $prefix = $node->create_child(
                    form => $form . ($self->dePOS ? '' : $node->upos),  # e.g. před-VERB
                    upos => $node->upos . '-',  # e.g. VERB-
                    feats => 'Affix=Prefix|RootUpos=' . $node->upos,
                    deprel => 'prefix',
                );
                $prefix->shift_before_node($node);
            } elsif ($form =~ /^-/) {
                # suffix, e.g. -il
                my $suffix = $node->create_child(
                    form => ($self->dePOS ? '' : $node->upos) . $form,  # e.g. VERB-il
                    upos => '-' . $node->upos,  # e.g. -VERB
                    feats => 'Affix=Suffix|RootUpos=' . $node->upos,
                    deprel => 'suffix',
                );
                $suffix->shift_after_node($last_suffix);
                $last_suffix = $suffix;
            } else {
                # root, e.g. stav
                $node->set_form($form);
            }
        }
    }

    if ($self->dePOS) {
        $node->set_feats('_');
    }

    return;
}

1;

__END__

=head1 DESCRIPTION

Split forms such as "před- stav -il" into separate nodes, conjoined with upos.
Lemmas are ignored because Parsito ignores them.

If C<dePOS=1>, then upos is set to _, -_ or _-, and morphofeatures are set to _, and form is not conjoined with upos (for EACH node).

