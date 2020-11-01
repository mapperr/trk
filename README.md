# trk

An unrefined cli time tracker.


## Usage

    Usage:
        trk
            shows a "today" report and the current timer, if active
        trk <entry_name>
            starts timer tracking a named entry
        trk t
            terminates the current timer
        trk r
            shows a report of all entries
        trk l
            lists the trk files
        trk a <entry_name> <time_spent>
            adds a new entry manually, with the specified time spent
            e.g.: "1 hour", "90 minutes", "2 hours", etc.
        trk e [trk_file]
            edit the trk file directly, only for the brave
        trk clean
            backup the current trk file and starts anew
        trk y
            sync: commits eventual changes and do a pull/push of the trk dir
        trk g git_args
            runs git with git_args in the trk dir
        trk help | h
            shows help

    Options:
        --help -h   Print this help

    Notes:
        - trk default dir is [$HOME/.trk]
        - to change default trk dir set TRK_DIR env var
        - to show debug infos set TRK_DEBUG env var to something


It's main use is to track the time spent on things in the current day.

It could be much more useful if it can report, say,
a weekly and monthly tracking.

### Improvements

1. make entries time interval human-editable
2. implement simple reports with a user-specified time interval
    (and a few custom ones, like 'week', 'month', 'lastweek', etc)
3. make possible to add a description to an entry

