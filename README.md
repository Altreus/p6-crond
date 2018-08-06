# crond.p6

A simple cron replacement, intended to remain in the foreground so it can be
used to keep a Docker container alive. This is in preference to installing cron
in an otherwise lightweight Debian installation because it's frankly ridiculous
that `cron` requires `mysql-common`.

Its usage is simple

    perl6 crond.p6 path-to-crontab

Currently this will ignore all environment variable declarations and run the
crons as usual, with whatever Perl 6 considers to be your shell.

# Dependencies

    zef install Chronic

# TODO

* Honour environment variables (modulo MAILTO - we'll always log to stdout)
