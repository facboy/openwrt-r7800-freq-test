#!/bin/sh

BIN_DIR="$(dirname $(readlink -f "$0"))"
. ${BIN_DIR}/functions.sh

function delay_mbw() {
    sleep 1
    quick_mbw
    echo
}

# default measurement
echo
echo "*** My defaults (ondemand)"
echo
quick_mbw

# set to performance governor
echo
echo "*** Setting performance governor"
echo

set_scaling_governor "performance"

set_scaling_max_freq 384
delay_mbw

set_scaling_max_freq 600
delay_mbw

set_scaling_max_freq 800
delay_mbw

set_scaling_max_freq 1000
delay_mbw

set_scaling_max_freq 1400
delay_mbw

set_scaling_max_freq 1725
delay_mbw

echo "*** Now seems to be busted"
echo

set_scaling_max_freq 800
delay_mbw

set_scaling_max_freq 1000
delay_mbw

set_scaling_max_freq 1400
delay_mbw

set_scaling_max_freq 1725
delay_mbw

RESTORE_FREQ=600
echo "*** Restored by setting to ${RESTORE_FREQ} first"
echo

set_scaling_max_freq ${RESTORE_FREQ} 1000
delay_mbw

set_scaling_max_freq ${RESTORE_FREQ} 1400
delay_mbw

set_scaling_max_freq ${RESTORE_FREQ} 1725
delay_mbw

set_scaling_max_freq ${RESTORE_FREQ} 1400
delay_mbw

BROKE_FREQ=1000
echo "*** Breaks when jumping from ${BROKE_FREQ}"
echo

set_scaling_max_freq ${BROKE_FREQ} 1000
delay_mbw

set_scaling_max_freq ${BROKE_FREQ} 1400
delay_mbw

set_scaling_max_freq ${BROKE_FREQ} 1725
delay_mbw

echo "Setting back to my defaults (ondemand)"
set_scaling_governor "ondemand"
set_scaling_max_freq 1725
delay_mbw
