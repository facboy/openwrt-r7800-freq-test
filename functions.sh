function errcho() {
    >&2 echo "$@"
}

function set_scaling_governor() {
    local GOVERNOR=$1
    if [ ${GOVERNOR} != "performance" -a ${GOVERNOR} != "ondemand" ]; then
        errcho "Invalid governor: ${GOVERNOR}"
        exit 255
    fi
    echo ${GOVERNOR} > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
    echo ${GOVERNOR} > /sys/devices/system/cpu/cpufreq/policy1/scaling_governor
}

function _set_max_scaling_freq_raw() {
    echo "Setting scaling_max_freq to ${1}"
    echo ${1} > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
    echo ${1} > /sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq
}

function set_scaling_max_freq() {
    local MBW=
    if [ $1 == "M" ]; then
        MBW="quick_mbw"
        shift 1
    fi

    _set_max_scaling_freq_raw "${1}000"
    echo_cur_freq
    ${MBW}

    shift 1
    for freq in "$@"; do
        sleep 1
        _set_max_scaling_freq_raw "${freq}000"
        echo_cur_freq
        ${MBW}
    done
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
