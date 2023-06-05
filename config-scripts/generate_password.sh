#!/bin/bash

usage() {
  echo "Usage: $(basename "$0") [--length <length>] [--withuppercase <yes|no>] [--withnumbers <yes|no>] [--withspecial <yes|no>]"
}

generate_password() {
  local length=$1
  local with_uppercase=$2
  local with_numbers=$3
  local with_special=$4

  local chars='abcdefghijklmnopqrstuvwxyz'

  if [[ $with_uppercase == "yes" ]]; then
    chars+='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  fi

  if [[ $with_numbers == "yes" ]]; then
    chars+='0123456789'
  fi

  if [[ $with_special == "yes" ]]; then
    chars+='@.-,_%'
  fi

  local password=""
  local chars_len=${#chars}

  for (( i=0; i<$length; i++ )); do
    local random_index=$((RANDOM % chars_len))
    password+=${chars:$random_index:1}
  done

  echo "$password"
}

length=""
with_uppercase="yes"
with_numbers="yes"
with_special="yes"

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --length)
      length="$2"
      shift
      shift
      ;;
    --withuppercase)
      with_uppercase="$2"
      shift
      shift
      ;;
    --withnumbers)
      with_numbers="$2"
      shift
      shift
      ;;
    --withspecial)
      with_special="$2"
      shift
      shift
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

if [[ -z $length ]]; then
  echo "Error: Password length is required."
  usage
  exit 1
fi

generate_password "$length" "$with_uppercase" "$with_numbers" "$with_special"
