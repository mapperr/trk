@_default:
    just -f {{justfile()}} --list

doc:
    #!/bin/sh
    TRK_USAGE="$(./trk h)" \
        envsubst '$TRK_USAGE' <README.tpl.md >README.md
