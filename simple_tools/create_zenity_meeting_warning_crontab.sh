#!/usr/bin/env bash

######################################
# Setup crontab for meeting reminder # 
######################################

# Get day and month
IFS=/ read month day year <<< $(zenity --calendar)

hour_regex='^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$'
while true; do
    # Get HH:MM
    meeting_time=$(zenity --entry --text="Insert meeting hour HH:MM format: ")
    if [[ $meeting_time =~ $hour_regex ]]; then
        break
    fi
done

# Split hour and minute
IFS=: read hour minute <<< $meeting_time

# Add crontab task and delete after execution using a timestamp to identify that line:
timestamp_reminder="reminder_$(date +%s)"
zenity_message="/usr/bin/zenity --warning --text='Meeting!' --display=:1"
crontab_entry="$minute $hour $day $month * $zenity_message; echo \"$timestamp_reminder\"; crontab -l | grep -v $timestamp_reminder | crontab -"

# Dump all cron tasks:
crontab -l > .cron.tasks.tmp
# We should use " to avoid * expand
echo "$crontab_entry" >> .cron.tasks.tmp && crontab .cron.tasks.tmp
rm .cron.tasks.tmp

{ echo "New cron task added. Date: $year/$month/$day $hour:$minute"; exit 0; }
