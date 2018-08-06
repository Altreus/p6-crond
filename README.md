# crond.p6

A simple cron replacement, intended to remain in the foreground so it can be
used to keep a Docker container alive. This is in preference to installing cron
in an otherwise lightweight Debian installation because it's frankly ridiculous
that `cron` requires `mysql-common`.

Its usage is simple

    perl6 crond.p6 path-to-crontab

Crontabs that come from a `cron.d` environment will also contain a username to
run the cron job as. You can tell the script about this, but the only effect is
to ignore it (otherwise, the username will be used as the command to run).

    perl6 crond.p6 --cron-d=1 path-to-crontab

Currently this will ignore all environment variable declarations and run the
crons as usual, with whatever Perl 6 considers to be your shell.

# Dependencies

    zef install Chronic

# TODO

