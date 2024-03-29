#!/usr/bin/env bash

cat <<EOT >> $HOME/.bashrc

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="[\$(date '+%Y-%m-%d %H:%M:%S')] {\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;36m\]\h} (\w\[\033[0;33m\])\$(parse_git_branch)$\[\033[0m\033[0;32m\] -> "
######################################################## Alias ######################################################### 
alias l="ls -ltrah"
alias c="xclip -selection clipboard"
alias dmesg="dmesg --human --kernel --follow --ctime"
alias random_password="dd if=/dev/urandom bs=1 count=12 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev"
alias testing_docker='echo Mounting: \`pwd\`; docker run -it -v \`pwd\`:/tmp/testing_virtualenv testing'
alias dockerip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias git_list_commited_changes="paste <(git log -1 --stat --oneline --decorate=no --pretty=\"format:\" --name-status) <(git log -1 --stat --oneline --pretty=\"format:\") | column -s $'\t' -tne"
alias random_ip="dd if=/dev/urandom bs=4 count=1 2>/dev/null | od -An -tu1 | sed -e 's/^ *//' -e 's/  */./g'"

##### Functions #####

function read_yaml() {
    python3 -c 'import yaml, sys; print(yaml.safe_load(sys.stdin))' < \$1
}

function mem() {
    ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{printf $1/1024 "MB"; $1=""; print }'
}

# ansible adhoc example
ansible localhost -m community.libvirt.virt -a "command=list_vms"
########################################################################################################################
EOT

source $HOME/.bashrc
