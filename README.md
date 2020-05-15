# trk

An unrefined cli time tracker.


## Usage

    trk
        shows a report and the current timer, if active
    trk <entry_name>
        starts tracking named entry
    trk s
        stops the current tracking
    trk a <entry_name> <time_spent>
        adds a new entry manually, with the specified time spent
    trk l [search_term]
        shows the full entry log or entries matching the search
    trk clean
        backup the current trk log and starts anew
    trk e
        edit the log file directly, only for the brave
    trk help | h
        shows help


It's main use is to track the time spent on things in the current day.

It could be much more useful if it can report, say, a weekly tracking.

