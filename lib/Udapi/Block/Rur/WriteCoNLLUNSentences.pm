package Udapi::Block::Rur::WriteCoNLLUNSentences;
use Moose;
extends 'Udapi::Block::Write::CoNLLU';
use utf8;

has N => ( is => 'rw', isa => 'Num', default => 256 );

around 'process_tree' => sub {
    my ($process_tree, $self, $tree) = @_;

    if (--$self->N) {
        return $self->process_tree($tree);
    }
};

1;

=head1 NAME 



=head1 DESCRIPTION

=head1 PARAMETERS

=over N

number of sentences to write

=back

=head1 AUTHOR

Rudolf Rosa <rosa@ufal.mff.cuni.cz>

=head1 COPYRIGHT AND LICENSE

Copyright © 2016 by Institute of Formal and Applied Linguistics,
Charles University in Prague

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

