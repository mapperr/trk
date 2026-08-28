# trk

`trk` is time tracking tool for the modern age:
shiny graphics, cool animations, touch gestures, cloud-native, k8s-microservices, AI-aware and ubiquitous synchronization.

...

Nah, is just a dumb time tracking tool for the command line.

It's offline. You use it on your computer. To track time spent on doing things, mostly work things.

It's a POSIX (-ish), very little, open-source shell script, so you can open it, look at it, change it, test it and send me a patch.

Usage:

```
Usage [v0.6.0]:
    trk t [description]
        without a description, stops the active timer;
        with a description, stops the active timer if necessary and starts a new one
    trk start <description>
    trk stop
    trk switch <description>
    trk status
        explicit timer commands
    trk tt [notification_interval_in_minutes, default: 5]
        notifies regularly while a timer is active

    trk a <date_arg> <hours> <description>
        adds a record; date_arg is accepted by GNU date, e.g. -, today, yesterday

    trk l [--stdin] [--grep|--date] [filter]
        lists records, optionally filtered by a grep pattern or date expression
    trk r [--stdin] [--grep|--date] [filter]
        reports total time, chargeability and per-tag totals
        input defaults to TRK_FILE; a real pipe/redirection is detected automatically
    trk check [--stdin]
        validates records and tags

    trk e
        edits the trk file with VISUAL or EDITOR
    trk g [git command/arguments]
        runs git in the trk file directory
    trk y [commit message]
        commits only the trk file, pulls with rebase and pushes
    trk h
        shows extended help

Record format:
    YYYY-MM-DD HOURS DESCRIPTION

    Fields are separated by one space. HOURS is a decimal number. DESCRIPTION
    is a single line and can contain tags such as:

    #billable #client:company-a #project:super_webapp #hid:25875920

Tags:
    A tag is #name or #name:value. Names and values contain letters, numbers,
    underscores and dashes. Tags are whitespace-separated tokens.
    #billable is used to calculate chargeability.

Filtering:
    Without options, a valid GNU date expression is converted to a date filter;
    any other value is treated as a basic grep regular expression.
    Expressions containing 'week', 'month' or 'year' select the whole period.
    --grep forces regular-expression interpretation.
    --date forces date interpretation.
    --stdin forces stdin. It is useful in non-interactive environments, although
    pipes and regular-file redirections are normally detected automatically.

Examples:
    trk a today 2.5 '#billable #client:acme implementation'
    trk l 'this week'
    trk l --grep '#client:acme.*#project:web'
    trk l 'this month' | trk r
    trk r --stdin '#billable' < exported-records
    trk check

Environment:
    TRK_DEBUG          enable diagnostic messages [current: unset]
    TRK_FILE           record file [current: ~/src/git.sr.ht/~mapperr/timetracking/trkfile]
    TRK_WORKDAY_HOURS  hours represented by one friendly-format day [current: 8]
    TRK_UNFRIENDLY     output report times as decimal hours with two decimals
    TRK_TAGS           tags prepended once to newly added records or timers
    VISUAL, EDITOR     editor command [current: $EDITOR]
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
tot_chargeability: 100%
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
