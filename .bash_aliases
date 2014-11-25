#!/bin/bash

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gpu='git pushup'
alias go='git checkout '
alias fall='git fetch --all --prune'

alias vm-start='TT=$PWD; cd /home/jeanseb/PhpstormProjects/lafourchette-vm/; ./lfvagrant resume; cd $TT'
alias vm-stop='TT=$PWD; cd /home/jeanseb/PhpstormProjects/lafourchette-vm/; ./lfvagrant suspend; cd $TT'
alias vm-ssh='TT=$PWD; cd /home/jeanseb/PhpstormProjects/lafourchette-vm/; ./lfvagrant ssh; cd $TT'

#function parse_git_branch() {
#  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#}
#PS1="\$(parse_git_branch)[\u@\h \W]\$ "
alias composer='hhvm ~/bin/composer.phar'
alias pu='clear; phpunit --debug '
alias pucov='clear; phpunit --debug --coverage-html web/coverage '
alias ft='clear; rm -rf app/cache/*; phing configure -DdbPrefix="test_b2c"; phpunit --debug -c ft.phpunit.xml; phing configure'
alias cs='phpcs --standard=PSR2 '
alias bonjour-projets='/home/vagrant/scripts/bonjour-projets.sh'
alias work-branches='/home/vagrant/scripts/work-branches.sh'
alias composer-install-all='/home/vagrant/scripts/composer-install-all.sh'
source /home/vagrant/www/lafourchette-admin-system/bin/aliases

# Restart applicative servers•
alias restartapp='for svc in memcached varnish php5-fpm; do sudo service $svc restart; done'
# Purge project cache
alias purgecache='for project in b2b bo portal core; do echo "Cleaning $project"; rm -rf /var/www/lafourchette-$project/app/cache/*; done'

# Both restart & purge
alias clean='restartapp; purgecache'

# shortcut
alias sf='app/console'

# do
alias domi='app/console do:mi:mi'

#
alias ass='app/console assets:install --symlink; app/console assetic:dump'
