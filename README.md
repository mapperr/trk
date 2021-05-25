# trk

An unrefined cli time tracker.


## Usage

    trk
        shows a 'today' report
    trk t <entry_name>
        starts a timer tracking a named entry
    trk t
        terminates the current timer
    trk <entry_name> <time_spent>
        adds a new entry manually, with the specified time spent
        e.g.: '40m', '2h', '1h20m', etc., with 'h' and 'm' being
        [h]ours and [m]inutes
        (you can even use [d]ays and [s]econds, but why should you? :)

    trk r
    trk r (today | week | month | lastweek | lastmonth) [-p]
        shows the current month report
        or a report of the time range specified:
        today, current week (starting from monday), current month, etc.
        with -p the output will be a parsable list of entries
    trk (m | mm) [-p]
        shortcut to 'trk r month' or 'trk r lastmonth'
    trk (w | ww) [-p]
        shortcut to 'trk r week' or 'trk r lastweek'
    trk M | MM
    trk W | WW
        same as above, but also reports each day of the time range
    trk s <query>
        greps through all trkfiles and report the results
        useful if you want to know the total time spent on an entry

    trk l
        lists the trk files
    trk e [trk_file]
        edit the trk file directly, defaulting to today trkfile
    trk y
        sync: commits eventual changes and do a pull/push of the trk dir
    trk g git_args
        runs git with git_args in the trk dir
    trk env
        prints exports of trk vars,
        eval-uating this output is useful for testing
    trk help | h
        shows help

    Options:
        --help -h   Print this help

    Notes:
        - trk default dir is [$HOME/.trk]
        - to change default trk dir set TRK_DIR env var
        - trk default workday hours is 8
        - to change workday hours set TRK_WORKDAY_HOURS env var
        - to show debug infos set TRK_DEBUG env var to something



It's main use is to track the time spent on things at work  
and help with the annoying task of reporting/budgeting spent hours.

## Tests

You can fire test with a trivial 
[SHUNIT2](https://github.com/kward/shunit2/) setup  
(just clone it and set an env var).

Check out the [test](https://git.sr.ht/~mapperr/trk/tree/master/test) script!

## Contribute

User the sr.ht tracking at https://todo.sr.ht/~mapperr/trk  
and the mailing list at https://lists.sr.ht/~mapperr/public-inbox

Thanks!
