@_default:
    just -f {{justfile()}} --list

doc:
    #!/bin/sh
    TRK_USAGE="$(./trk h | sed "s@$HOME@~@"| sed "s@$EDITOR@\$EDITOR@" | sed 's/cur: .*]/cur: ...]/')" \
    envsubst '$TRK_USAGE' <README.tpl.md >README.md
