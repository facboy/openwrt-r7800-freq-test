#!/bin/sh

BIN_DIR="$(dirname $(readlink -f "$0"))"
. ${BIN_DIR}/functions.sh

function usage() {
    errcho "Usage:"
    errcho "    $0 [-i <init_freq>] -m <max_freq>"
    errcho
    errcho "    Frequencies are in MHz"
    errcho
    errcho "    -i    Set an initial frequency before setting the main frequency"
    errcho "    -m    Run mbw after setting frequencies"
    exit 255
}

MBW=0
INIT_FREQ=
while getopts 'mi:' opt; do
    case $opt in
        i) INIT_FREQ=${OPTARG} ;;
        m) MBW=1 ;;
        *) usage
    esac
done
shift $(($OPTIND - 1))

if [ $# -ne 1 ]; then
    usage
fi

set_scaling_max_freq ${INIT_FREQ} "$1"
echo_cur_freq

if [ ${MBW} -eq 1 ]; then
    quick_mbw
fi
