function errcho() {
    >&2 echo "$@"
}

function set_scaling_governor() {
    GOVERNOR=$1
    if [ ${GOVERNOR} != "performance" -a ${GOVERNOR} != "ondemand" ]; then
        errcho "Invalid governor: ${GOVERNOR}"
        exit 255
    fi
    echo ${GOVERNOR} > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
    echo ${GOVERNOR} > /sys/devices/system/cpu/cpufreq/policy1/scaling_governor
}

function set_scaling_max_freq() {
    MAX_FREQ="${1}000"
    if [ $# -eq 2 ]; then
        INIT_FREQ="${1}000"
        MAX_FREQ="${2}000"
        echo "Setting initial scaling_max_freq to ${INIT_FREQ}"
        echo ${INIT_FREQ} > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
        echo ${INIT_FREQ} > /sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq
        sleep 1
    fi

    echo "Setting scaling_max_freq to ${MAX_FREQ}"
    echo ${MAX_FREQ} > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
    echo ${MAX_FREQ} > /sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq
}

function echo_cur_freq() {
    echo "cpu0 cur_freq: $(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq)"
    echo "cpu1 cur_freq: $(cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq)"
}

function time_xz() {
    echo "Timing xz /root/test.tar:"
    time xz -6 -c /root/test.tar > /tmp/test.tar.xz
}

function quick_mbw() {
    ${BIN_DIR}/mbw -q 1 | grep -E "^AVG"
}
