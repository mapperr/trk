# trk

`trk` is time tracking tool for the modern age:
shiny graphics, cool animations, touch gestures, cloud-native, k8s-microservices, AI-aware and ubiquitous synchronization.

...

Nah, is just a dumb time tracking tool for the command line.

It's offline. You use it on your computer. To track time spent on doing things, mostly work things.

It's a POSIX (-ish), very little, open-source shell script, so you can open it, look at it, change it, test it and send me a patch.

Usage:

```
Usage [v0.5.0]:
    trk t <description>
        starts a timer for a new entry
        eventually terminates the previously active timer
    trk t
        terminates the current timer
    trk tt [notification_interval_in_minutes, default:5]
        starts a long running process that notifies regurarly if there is an active timer

    trk a <date_arg> <hours> <description>
        adds a new entry to the trk file.
        date_arg is any valid value the 'date' command can take, e.g. '-', 'today', 'yesterday', etc.
        hours spent must be a number and can be decimal: 1, 4.25, 0.5, etc.

    trk l [grep_pattern | date_arg]
        prints trk records to stdout, filtering records with grep_pattern or a date_arg if passed.
        by default it reads the trk file, but it can alternatively take input from stdin

    trk r [grep_pattern | date_arg]
        shows an aggregate of trk records with per-tag totals,
        filtering records with grep_pattern or a date_arg if passed.
        by default it reads the trk file, but it can alternatively take input from stdin

    trk e
        edits the trk file with your vis

    trk g [git cmds/args]
        executes git commands in the trk file directory, e.g.: trk g pull
    trk y [commit msg]
        executes git add, commit -m 'commit msg' (or 'sync'), pull and push in the tsk directory
    trk h
        shows extended help

trkfile:
    the trk file contains a list of trk records, one per line.
    the trk record format is simply: DAY HOURS DESCRIPTION (separated by exactly 1 blank space)
    where: DAY: YYYY-MM-DD, HOURS: a floating point number, DESCRIPTION: a one-line note with optional tags (see below)
    so, e.g.: '2025-01-23 4.5 #billable #client:companyA #project:super_webapp work on backend feature X'

tags:
    descriptions can contain 'tags' in the form of #tag or #tag:value
    (tag and value can contain only letters, numbers, undescores '_' and dashes '-', without blank spaces).
    those tags will result in the reports as additional aggregates or can be used by external integrations.

filtering:
    the l[ist] and r[eport] commands optionally take a grep pattern or a date arg as input.
    the grep pattern is obviously grep-compatible a regex.
    The date arg is a value that is a valid 'date' command 'DATE STRING': something like yesterday, 7 days ago, etc. 
    trk tries to be smart, e.g.: if the date arg contains 'month' or 'week', then it adjust the resulting filter to grep the entire month/week.
    
env vars:
    - TRK_DEBUG: set it to whatever value to show debug informations [default: unset, cur: unset]
    - TRK_FILE: the trk file you are working on [default: /home/mapperr/.trkfile, cur: /home/mapperr/src/git.sr.ht/~mapperr/timetracking/trkfile]
    - TRK_WORKDAY_HOURS: workday hours [default: 8, cur: 8]
    - TRK_UNFRIENDLY: prints spent time in hours with 2 decimals, useful for sorting, parsing, etc. [default: unset, cur: unset]
    - TRK_TAGS: trk will prepend the content of this var to the record description,
        useful if, e.g., you are working on a specific client/project all day [default: unset, cur: unset]
```


# Basic usage

```
# setup

# copy/link trk in your PATH

# start a timer
$ trk t #client:google #project:user_data_collector_service #billable flowing unencrypted user data into company servers
trk: started new timer: #client:google #project:user_data_collector_service #billable flowing unencrypted user data into company servers

# work some time on this noble cause, with a careful work/life balance

# check the timer
$ trk r
timer: 76d4h15m #client:google #project:user_data_collector_service #billable flowing unencrypted user data into company servers

# ok, work finished, let's stop the timer
$ trk t
trk: record added: 2025-11-28 612.25 #client:google #project:user_data_collector_service #billable flowing unencrypted user data into company servers

# let's check our trk file
$ trk c
2025-11-28 612.25 #client:google #project:user_data_collector_service #billable flowing unencrypted user data into company servers

# oh, boss want to talk...
# uff, meeting done

# damn, I forgot to track the short meeting with my boss done today
$ trk a - 7.5 #client:mycompany #meeting very short meeting with Carl about how well I underperform
trk: record added: 2025-11-28 7.5 #client:mycompany #meeting very short meeting with Carl about how well I underperform

# wow, it's friday, I have to report what I've done
$ trk r .

tag: #billable 76d4h15m
tag: #client:google 76d4h15m
tag: #client:mycompany 7h30m
tag: #meeting 7h30m
tag: #project:user_data_collector_service 76d4h15m

tot_spent: 77d3h45m
```

Also you can:

- pipe some trk-formatted input into `trk r` to get a report
- run `trk tt & disown` to start a notification process that bugs you with current elapsed timer
- use another trk file with `export TRK_FILE=~/.my_other_trkfile`
- use things like `dotenv` to set TRK_FILE/TRK_TAGS when you are in a directory

and other little quirks you can come up with.

## Integrations

- [harvest](https://www.getharvest.com/) -> put `trk-harvest` in your path and check out `trk harvest h`

## Development

The source is hosted on https://git.sr.ht/~mapperr/trk
