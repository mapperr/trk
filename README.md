# trk

An unrefined cli time tracker.


## Usage

    trk
        shows a "today" report and the current timer, if active
    trk <entry_name>
        starts timer tracking a named entry
    trk <entry_name> <time_spent>
        adds a new entry manually, with the specified time spent
        e.g.: "1h", "1h20m", "2d", etc.
    trk t
        terminates the current timer
    trk r today | month
    trk r [from] [to]
        shows a report of the time range specified
        format of the time range is %Y-%m-%d
    trk l
        lists the trk files
    trk e [trk_file]
        edit the trk file directly, only for the brave
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

It's main use is to track the time spent on things in the current day.

### Improvements

- ✓ make entries time interval human-editable
- implement simple reports with a user-specified time interval
    (and a few custom ones, like 'week', 'month', 'lastweek', etc)
- make possible to add a description to an entry

