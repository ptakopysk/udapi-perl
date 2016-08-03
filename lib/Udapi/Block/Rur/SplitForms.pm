package Udapi::Block::Rur::SplitForms;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

# TODO also add a variant without appendig POS

sub process_node {
    my ($self, $node) = @_;

    if ($node->form =~ / /) {
        my @forms = split / /, $node->form;
        my $last_suffix = $node;  # after which node to put a new suffix
        foreach my $form (@forms) {
            if ($form =~ /-$/) {
                # prefix, e.g. před-
                my $prefix = $node->create_child(
                    form => $form . $node->upos,  # e.g. před-VERB
                    upos => $node->upos . '-',  # e.g. VERB-
                    feats => 'Affix=Prefix|RootUpos=' . $node->upos,
                    deprel => 'prefix',
                );
                $prefix->shift_before_node($node);
            } elsif ($form =~ /^-/) {
                # suffix, e.g. -il
                my $suffix = $node->create_child(
                    form => $node->upos . $form,  # e.g. VERB-il
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

    return;
}

1;

__END__

=head1 DESCRIPTION

Split forms such as "před- stav -il" into separate nodes.
Lemmas are ignored because Parsito ignores them.

