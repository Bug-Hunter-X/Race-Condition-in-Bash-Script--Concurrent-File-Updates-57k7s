#!/bin/bash

# This script demonstrates a solution to the race condition using a lock file.

file="shared_file.txt"
lock_file="shared_file.lock"
echo "Initial value" > "$file"

process1() {
  while true; do
    # Acquire lock
    flock -n "$lock_file" || exit 1  # Exit if lock cannot be acquired
    value=`cat "$file"`
    new_value=$((value + 1))
    echo "Process 1: Updating from $value to $new_value"
    echo $new_value > "$file"
    # Release lock
    flock -u "$lock_file"
    sleep 0.1
  done
}

process2() {
  while true; do
    # Acquire lock
    flock -n "$lock_file" || exit 1  # Exit if lock cannot be acquired
    value=`cat "$file"`
    new_value=$((value * 2))
    echo "Process 2: Updating from $value to $new_value"
    echo $new_value > "$file"
    # Release lock
    flock -u "$lock_file"
    sleep 0.1
  done
}

# Run processes in background
process1 &
process2 &

# Wait some time to observe behavior
sleep 5

# Clean up processes (use `pkill -f process` on linux for a more robust solution)
kill $!
kill %2

# Final value should be more consistent
final_value=`cat "$file"`
echo "Final value: $final_value"