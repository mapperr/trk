# trk

`trk` is a small, offline time tracker for the command line.

It stores plain-text records, uses ordinary tags, supports timers and reports,
and can be extended with separate executables. There is no database, daemon,
account or mandatory network service: the trk file is the data.

`trk` is written in POSIX shell and is intentionally easy to inspect, change
and move between machines.

## Quick start

Put `trk` somewhere in `PATH`:

```sh
install -m 0755 trk "$HOME/bin/trk"
```

Or link the core and every installed extension with the included `justfile`:

```sh
just link
just link "$HOME/.local/bin"
```

Add a record:

```sh
trk add today 2.5 +billable +client:acme +project:web implemented importer
```

Start, inspect and stop a timer:

```sh
trk start +client:acme +project:web investigated timeout
trk status
trk stop
```

List and report the current week:

```sh
trk list 'this week'
trk report 'this week'
```

## Record format

Each non-comment line is one record:

```text
YYYY-MM-DD HOURS DESCRIPTION
```

For example:

```text
2026-09-29 2.5 +billable +client:acme +project:web implemented importer
```

- `HOURS` is a signed decimal number.
- The description is a single line.
- Blank lines and lines beginning with `#` are ignored.
- Fields are separated by spaces.

The default file is `$HOME/.trkfile`. Set `TRK_FILE` to use another one.

## Tags

A tag is a whitespace-separated token in one of these forms:

```text
+name
+name:value
```

Names and values may contain letters, numbers, underscores and dashes. Tags
are included in reports; repeated copies of the same tag in one record are
counted once. `+billable` contributes to the chargeability percentage.

The old `#tag` syntax is not accepted. `#` at the beginning of a line is
reserved for comments and configuration directives.

### Default tags

`TRK_TAGS` prepends tags to every new record and timer:

```sh
export TRK_TAGS='+client:acme +project:web'
trk add today 1 fixed validation
```

## Meta-tags

A meta-tag is a reusable group of normal tags. Define mappings as comments in
the trk file:

```text
# map: ++acme-web +client:acme +project:web +billable
```

Records can then stay compact:

```text
2026-09-29 2.5 ++acme-web implemented importer
```

`list`, filtering and reporting see the expanded normal tags. The `++...`
token itself is omitted from `list` output, so extensions cannot copy it into
remote notes. The compact record is not changed on disk.

Inspect mappings with:

```sh
trk maps
trk maps ++acme-web
```

Mappings cannot contain other meta-tags. Missing, duplicated or conflicting
mappings are errors. An explicit tag also cannot contradict a mapped tag.

Mappings are dynamic: changing one changes the effective tags of every record
that uses it. To freeze the current meaning, replace meta-tags with normal tags:

```sh
trk materialize --dry-run
trk materialize
```

The real operation writes `$TRK_FILE.bak` and replaces the trk file atomically.

## Timers

The short timer command toggles the current timer:

```sh
trk t DESCRIPTION     # start
trk t                 # stop
trk t DESCRIPTION     # stop the old timer and start another
```

The explicit equivalents are:

```sh
trk start DESCRIPTION
trk stop
trk switch DESCRIPTION
trk status
```

Timers crossing midnight are split into one record per calendar day. A timer
shorter than one minute is discarded.

`trk tt [minutes]` runs a foreground notification loop. It requires
`notify-send`; the default interval is five minutes.

## Listing and filtering

```sh
trk list [--stdin] [--grep|--date] [filter]
```

Without a mode option, a value understood by GNU `date` is treated as a date;
anything else is a basic `grep` regular expression.

```sh
trk list today
trk list 'this week'
trk list 2026-09
trk list --grep '+client:acme.*+project:web'
trk list --date 2026-09-29
```

`week`, `month` and `year` expressions select the complete corresponding
period. `--grep` and `--date` remove any ambiguity.

Input normally comes from `TRK_FILE`. Pipes and regular-file redirections are
detected automatically; `--stdin` forces standard input:

```sh
trk list 'this month' | trk report --stdin
trk report --stdin +billable < exported-records
```

## Reports and workday audit

```sh
trk report [--stdin] [--grep|--date] [filter]
```

A report contains:

- total hours for every tag;
- incomplete workdays;
- total time;
- chargeability based on `+billable`.

Example with `TRK_WORKDAY_HOURS=8`:

```text
tag: +billable 1d
tag: +client:acme 2d

incomplete_day: 2026-09-28 7h delta:-1h
incomplete_day: 2026-09-29 1d1h delta:+1h

tot_spent: 2d
tot_chargeability: 50.00%
```

Only days represented by the selected records are checked. Therefore a grep
filter audits the filtered subset, while a date filter normally audits the full
selected days. Comparisons are rounded to the nearest second.

Set `TRK_UNFRIENDLY` to print decimal hours instead of friendly durations:

```sh
TRK_UNFRIENDLY=1 trk report 'this month'
```

## Validation

Validate the trk file before importing or synchronizing records:

```sh
trk check
trk check --stdin < another-trkfile
```

`check` verifies record structure, real calendar dates, numeric hours, tags,
meta-tag definitions, missing mappings and tag conflicts. It returns a non-zero
status when validation fails.

## Editing and Git

```sh
trk edit
trk git status
trk sync 'monthly update'
```

- `edit` opens the trk file with `VISUAL`, then `EDITOR`, then `vi`.
- `git` runs an arbitrary Git command in the trk file directory.
- `sync` stages only the trk file, commits it when changed, pulls with rebase
  and pushes. Its default commit message is `sync`.

## Commands

| Command | Short form | Purpose |
| --- | --- | --- |
| `t [description]` | | Toggle the timer or switch its description |
| `start`, `stop`, `switch`, `status` | `status`: `s` | Manage the timer explicitly |
| `add` | `a` | Append a record |
| `list` | `l` | Print selected records |
| `report` | `r` | Aggregate time and audit workdays |
| `check` | | Validate records and mappings |
| `maps` | | List meta-tag mappings |
| `materialize` | | Freeze meta-tag expansions |
| `edit` | `e` | Edit the trk file |
| `git` | `g` | Run Git in the data directory |
| `sync` | `y` | Commit, pull and push the trk file |
| `help` | `h` | Show complete built-in help |

Run `trk help` for the authoritative command synopsis.

## Configuration

| Variable | Meaning | Default |
| --- | --- | --- |
| `TRK_FILE` | Record file | `$HOME/.trkfile` |
| `TRK_TAGS` | Tags or meta-tags added to new records | empty |
| `TRK_WORKDAY_HOURS` | Workday length and friendly `d` unit | `8` |
| `TRK_UNFRIENDLY` | Use decimal hours when non-empty | empty |
| `TRK_DEBUG` | Print query diagnostics when non-empty | empty |
| `VISUAL`, `EDITOR` | Editor selection | `vi` |

## Extensions

The core is provider-agnostic. An executable named `trk-NAME` anywhere in
`PATH` automatically becomes the command:

```text
trk NAME [arguments...]
```

For example, an extension installed as `trk-export` is invoked with
`trk export`. Extensions may implement synchronization, export, interactive
selection or any other workflow without adding provider-specific code to the
core.

An extension should normally consume records through `trk list` and validate
them with `trk check`. This preserves filtering, stdin handling and meta-tag
expansion. It can inspect `trk --version` when it needs a minimum core version.

The archive may include optional `trk-*` connector scripts. Each remains a
standalone program with its own help, configuration and dependencies:

```sh
trk NAME help
```

`trk run` exists as a narrow bridge for extensions that need a core helper;
those helpers are internal and less stable than the public commands.

## Development and tests

Run the self-contained regression suite with:

```sh
./tests/run
# or
just test
```

The suite exercises the public CLI in isolated temporary directories. It
covers addition, timers, input validation, filtering, stdin, reports, workday
auditing, meta-tags, materialization and extension dispatch. No network access
or external test framework is required.

The source repository is hosted at:

<https://git.sr.ht/~mapperr/trk>

## Requirements

The core expects a POSIX shell and common Unix tools. Date parsing relies on
GNU `date`. Git and `notify-send` are required only by the commands that use
them. Individual extensions may have additional dependencies.

## License

GNU General Public License version 3 or later. See `LICENSE`.
