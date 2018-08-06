#!perl6

use v6;
use Chronic;

sub MAIN (Str $crontab) {
    my @jobs;

    for $crontab.IO.lines.kv -> $i, $line is copy {
        # cron jobs cannot span lines. Remove comment and skip the line if
        # there's nothing left.
        $line ~~ s/ '#' .+ //;
        next unless $line ~~ / \S /;

        next if $line ~~ / ^ <alpha>+ '=' /;

        my @split = $line.split( / \s+ /, 6);
        my $command = @split.pop;

        # shaped variable declarations not yet implemented
        my %time;
        %time<minute hour day-of-month month day-of-week> = @split;
        push @jobs, { spec => %time, command => $command };
    }

    for @jobs -> $jobspec {
        Chronic.every(|$jobspec<spec>).tap({ shell $jobspec<command> });
    }

    Chronic.supply.wait;
}
