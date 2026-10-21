#!/bin/bash
set -euo pipefail

TECHNIQUE="T1087.001 - Local Account Discovery"
STOP_FLAG="stop_test.flag"
RESULTS_FILE="atomic_results.txt"
LOG_FILE="atomic_log.txt"

# Check whether the simulation must stop
check_stop() {
    if [[ -e "$STOP_FLAG" ]]; then
        echo "stop_test.flag detected. Aborting simulation."
        echo "Remove the flag file to allow execution."
        exit 1
    fi
}

# Refuse to start if stop flag exists
check_stop

echo "MITRE ATT&CK Technique: $TECHNIQUE"

START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo "Start time: $START_TIME"
echo "[$START_TIME] START - $TECHNIQUE" >> "$LOG_FILE"

# Log completion or interruption
finish() {
    local status=$?
    local end_time

    end_time=$(date '+%Y-%m-%d %H:%M:%S')

    echo "[$end_time] END - $TECHNIQUE (exit: $status)" >> "$LOG_FILE"
    echo "End time: $end_time"

    if (( status == 0 )); then
        echo "Simulation complete. Review $LOG_FILE for details."
    else
        echo "Simulation aborted (exit code: $status)." >&2
    fi
}

trap finish EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

echo "Running simulation..."

# Discover local accounts using /etc/passwd
check_stop
cat /etc/passwd > "$RESULTS_FILE"

check_stop

echo "Output saved to $RESULTS_FILE"
