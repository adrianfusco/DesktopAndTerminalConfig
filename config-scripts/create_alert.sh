#!/bin/bash


# Function to display an error message and exit the script
function display_error() {
  echo "Error: $1"
  exit 1
}

# Check if dialog is installed
if ! command -v dialog &>/dev/null; then
  display_error "The 'dialog' utility is not installed. Please install it and try again."
fi

# Check if notify-send is installed
if ! command -v notify-send &>/dev/null; then
  display_error "The 'notify-send' command is not installed. Please install it and try again."
fi

# Check if paplay is installed
if ! command -v p3aplay &>/dev/null; then
  display_error "The 'paplay' command is not installed. Please install it and try again."
fi

# Function to display the alert
function display_alert() {
  local description="$1"
  
  # Generate a sound using the speaker beep
  printf '\a'
  
  # Show a popup notification
  notify-send "Alert" "$description" && paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}

# Function to show the calendar dialog
function show_calendar_dialog() {
  dialog --stdout --calendar "Select Date" 0 0
}

# Function to show the time dialog
function show_time_dialog() {
  dialog --stdout --timebox "Select Time" 0 0
}

# Function to show the description dialog
function show_description_dialog() {
  dialog --stdout --inputbox "Enter Description" 0 0
}

# Get the current datetime and calculate the default datetime for the alert
current_datetime=$(date "+%Y-%m-%d %H:%M")
default_datetime=$(date -d "$current_datetime + 2 minute" "+%Y-%m-%d %H:%M")

# Prompt the user to enter the date
date_input=$(show_calendar_dialog)
date_input="${date_input:-$(date -d "$default_datetime" +%Y-%m-%d)}"

# Prompt the user to enter the time
time_input=$(show_time_dialog)
time_input="${time_input:-$(date -d "$default_datetime" +%H:%M)}"

# Prompt the user to enter the description
description=$(show_description_dialog)

# Combine the date and time inputs
datetime="${date_input} ${time_input}"

# Validate the datetime format
if ! date -d "$datetime" >/dev/null 2>&1; then
  echo "Invalid datetime format. Please provide a valid date and time."
  exit 1
fi

# Calculate the time difference in seconds
current_timestamp=$(date "+%s")
alert_timestamp=$(date -d "$datetime" "+%s")
time_diff=$((alert_timestamp - current_timestamp))

# Check if the alert time is in the past
if [ "$time_diff" -lt 0 ]; then
  echo "The specified alert time is in the past. Please provide a future date and time."
  exit 1
fi

# Sleep until the alert time in the background
(sleep "$time_diff" && display_alert "$description") & disown

