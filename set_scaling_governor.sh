#!/bin/sh

BIN_DIR="$(dirname $(readlink -f "$0"))"
. ${BIN_DIR}/functions.sh

if [ $# -ne 1 ]; then
    errcho "Usage:"
    errcho "    $0 <governor>"
    errcho
    errcho "    Valid governors are \"ondemand\" or \"performance\""
    exit 255
fi

set_scaling_governor $1
