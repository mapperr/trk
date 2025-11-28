# trk

`trk` is time tracking tool for the modern age:
shiny graphics, cool animations, touch gestures, cloud-native, k8s-microservices, meme-aware and ubiquitous synchronization.

...

Nah, is just a dumb time tracking tool for the command line.

It's offline. You use it on your computer. To track time spent on doing things, mostly work things.

It's a POSIX (-ish), very little, open-source shell script, so you can open it, look at it, change it, test it and send me a patch.

Usage:

```
${TRK_USAGE}
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
timer_start: 2025-09-22 15:23:27
timer_descr: #client:google #project:user_data_collector_service #billable flowing unencrypted user data into company servers
timer_elaps: 76d4h15m

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

