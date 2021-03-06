#!perl6

use v6;
use Chronic;

sub MAIN (Str $crontab, :$cron-d) {
    my @jobs;

    for $crontab.IO.lines -> $line is copy {
        # cron jobs cannot span lines. Remove comment and skip the line if
        # there's nothing left.
        $line ~~ s/ '#' .+ //;
        next unless $line ~~ / \S /;

        # Some lines are env vars
        if $line ~~ / ^ (<alpha>+) '=' (.*) $ / {
            %*ENV{$0} = $1;
            next;
        }

        my @split = $line.split( / \s+ /, $cron-d ?? 7 !! 6);
        my $command = @split.pop;

        @split.pop if $cron-d;

        # shaped variable declarations not yet implemented
        my %time;
        %time<minute hour day-of-month month day-of-week> = @split;
        push @jobs, { spec => %time, command => $command };
    }

    for @jobs -> $jobspec {
        Chronic.every(|$jobspec<spec>).tap({
            my $proc = shell $jobspec<command>;

            CATCH {
                warn $_;
            }
        });
    }

    Chronic.supply.wait;
}
