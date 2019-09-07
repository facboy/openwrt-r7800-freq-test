#!/bin/sh

BIN_DIR="$(dirname $(readlink -f "$0"))"
. ${BIN_DIR}/functions.sh

function usage() {
    errcho "Usage:"
    errcho "    $0 [-m] <freq1> [<freq2> <freq3> ...] "
    errcho
    errcho "    Frequencies are in MHz"
    errcho
    errcho "    -m    Run mbw after setting frequencies"
    exit 255
}

MBW=0
INIT_FREQ=
while getopts 'm' opt; do
    case $opt in
        m) MBW=1 ;;
        *) usage
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 1 ]; then
    usage
fi

if [ ${MBW} -eq 1 ]; then
    set_scaling_max_freq "M" "$@"
else
    set_scaling_max_freq "$@"
fi
