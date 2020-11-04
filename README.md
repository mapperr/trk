# trk

An unrefined cli time tracker.


## Usage


    Usage:
        trk
            shows a 'today' report
        trk <entry_name>
            starts a timer tracking a named entry
        trk <time_spent> <entry_name>
            adds a new entry manually, with the specified time spent
            e.g.: '40m', '2h', '1h20m', etc., with 'h' and 'm' being
            [h]ours and [m]inutes
            (you can even use [d]ays and [s]econds, but why should you? :)
        trk t
            terminates the current timer
        trk r
        trk r today | month
            shows the monthly report
            or a report of the time range specified
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

You can fire test with a trivial SHUNIT2 setup  
(just clone it and set an env var).

Check out the `test` script!

## Contribute

User the sr.ht tracking at https://todo.sr.ht/~mapperr/trk  
and the mailing list at https://lists.sr.ht/~mapperr/public-inbox

Thanks!
