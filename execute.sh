#!/usr/bin/env bash

PROJECT_FOLDER=$(readlink -e $(dirname "$0"))
SCRIPTS_FOLDER="config-scripts"

if [[ ! -d "$PROJECT_FOLDER/$SCRIPTS_FOLDER" ]]; then
    echo "Scripts folder does not exist"
fi

for script in $(ls -1 "$PROJECT_FOLDER/$SCRIPT_FOLDER"); do
    bash $script
done

cp .vimrc ~/.vimrc
