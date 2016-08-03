package Udapi::Block::Rur::MergeForms;
use Udapi::Core::Common;
extends 'Udapi::Core::Block';

sub process_tree {
    my ($self, $tree) = @_;

    foreach my $node ($tree->descendants()){
        $self->clean_up_form($node);
    }
    foreach my $node ($tree->descendants()){
        $self->merge_to_root($node);
    }

    return ;
}

sub clean_up_form {
    my ($self, $node) = @_;

    my $upos = $node->upos;
    my $form = $node->form;
    if ($upos =~ /-$/) {
        # prefix, e.g. upos = VERB- form = před-VERB
        $form =~ s/-.*$//;
    } elsif ($upos =~ /^-/) {
        # suffix, e.g. upos = -VERB form = VERB-il
        $form =~ s/^.*-//;
    }

    $form =~ s/@/-/g; # undo escaping
    $node->set_form($form);

    return;
}

sub merge_to_root {
    my ($self, $node) = @_;

    my $upos = $node->upos;
    my $form = $node->form;
    if ($upos =~ /-$/) {
        # prefix, e.g. upos = VERB- form = před
        $node->next_node()->set_form(
            $form . $node->next_node()->form);
        $node->remove({children=>'rehang_warn'});
    } elsif ($upos =~ /^-/) {
        # suffix, e.g. upos = -VERB form = il
        $node->prev_node()->set_form(
            $node->prev_node()->form . $form);
        $node->remove({children=>'rehang_warn'});
    }

    return ;
}

1;

__END__

=head1 DESCRIPTION

Merge split forms such as "před- stav -il" into a single node.
(Lemmas are ignored because Parsito ignores them.)

