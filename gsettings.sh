#!/bin/bash

############ How it works: ################################################
#	These are examples:
#	Get actual setted click-policy
#	gsettings get org.gnome.nautilus.preferences click-policy
#	List available options:
#	gsettings range org.gnome.nautilus.preferences click-policy
#	Set an option:
#	gsettings set org.gnome.nautilus.preferences click-policy single
# 	Examples:
#	http://bookofzeus.com/customize-ubuntu/install/things-to-do-after-installing-ubuntu/
###########################################################################

############################# Text Editor #############################
gsettings set org.gnome.gedit.preferences.editor auto-save true
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor display-right-margin true
gsettings set org.gnome.gedit.preferences.editor auto-save-interval 1
gsettings set org.gnome.gedit.preferences.editor tabs-size 4

### Styles are in: /usr/share/gtksourceview-3.0/styles/ ###
gsettings set org.gnome.gedit.preferences.editor scheme 'cobalt'

############################# Mouse pointer #############################
gsettings set org.gnome.desktop.interface cursor-theme 'core'

############################# Desktop interface theme #############################
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

############################# Nautilus #############################
gsettings set org.gnome.nautilus.list-view use-tree-view true
gsettings set org.gnome.nautilus.preferences click-policy single
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
# After it, open nautilus and execute Ctrl+L
gsettings set org.gnome.nautilus.preferences always-use-location-entry true


cat <<EOT >> $HOME/.bashrc
export PS1="[\$(date '+%Y-%m-%d %H:%M:%S')] {\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;36m\]\h} (\w\[\033[0;33m\])\$(__git_ps1)$\[\033[0m\033[0;32m\] -> "

##### Alias #####
alias l="ls -ltrah"
alias c="xclip -selection clipboard"
alias dmesg="dmesg --human --kernel --follow --ctime"
alias random_password="dd if=/dev/urandom bs=1 count=12 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev"

##### Functions #####
function read_yaml() {
    python3 -c 'import yaml, sys; print(yaml.safe_load(sys.stdin))' < $1
}

function mem() {
    ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{printf $1/1024 "MB"; $1=""; print }'
}
EOT

source $HOME/.bashrc

