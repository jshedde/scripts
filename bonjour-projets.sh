#!/bin/bash

CURRENT_USER=jshedde
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERT="\\033[1;32m" 
ROUGE="\\033[37;41m" 
NORMAL="\\033[0;39m"
JAUNE="\\033[30;43m"
function greenify()
{
    echo -e "$VERT$1$NORMAL"
}

function redify()
{
    echo -e "$ROUGE$1$NORMAL"
}

function yellify()
{
    echo -e "$JAUNE$1$NORMAL"
}

function fetchAll()
{
    greenify "Fetching..."
    git fetch --all --prune 2>/dev/null >/dev/null
}
function currentBranch()
{
    CURR_BR=`git branch  2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    echo -e "Branche courante : $CURR_BR"
}

function originIsLaFouchette()
{
    PROJECT=$1
    ORIGIN_LAFOURCHETTE=`git remote -v | grep origin | grep ":lafourchette/" -c`
    if [ $ORIGIN_LAFOURCHETTE -eq 0 ]; then
        REMOTE="git@github.com:lafourchette/$PROJECT.git"
        git remote set-url origin $REMOTE
        git remote set-url origin --push _NOPUSH_
        yellify "Origin has been setted to \"$REMOTE\""
    fi
}

function disablingPushOnOrigin()
{
    PROJECT=$1
    ORIGIN_PUSH=`git remote -v | grep origin | grep push | grep "lafourchette" -c`
    if [ $ORIGIN_PUSH -eq 1 ]; then
        git remote set-url origin --push _NOPUSH_
        yellify "Disabling push to origin."
    fi
}

function addingUpstream()
{
    PROJECT=$1

    CURRENT_USER_REMOTE=`git remote -v | grep "upstream" -c`
    if [ $CURRENT_USER_REMOTE -eq 0 ]; then
        git remote add upstream git@github.com:lafourchette/$PROJECT.git
        yellify "Adding remote upstream"
    fi
}

function addingRemoteForCurrentUser()
{
    PROJECT=$1

    CURRENT_USER_REMOTE=`git remote -v | grep ":$CURRENT_USER/" -c`
    if [ $CURRENT_USER_REMOTE -eq 0 ]; then
        git remote add $CURRENT_USER git@github.com:$CURRENT_USER/$PROJECT.git
        yellify "Adding remote $CURRENT_USER"
    fi
}

function settingHooks()
{
    PROJECT_DIR=$1
    PRECOMMIT=$PROJECT_DIR/.git/hooks/pre-commit
    rm -f $PRECOMMIT
    ln -s $SCRIPT_DIR/git-hooks/pre-commit/ahsio/pre-commit $PRECOMMIT
    chmod +x $PRECOMMIT
}
WORKSPACE=/var/www
PWD_BACK=$PWD
for dir in `ls $WORKSPACE`
do
    PROJECT_DIR=$WORKSPACE/$dir
    if [ -d $PROJECT_DIR ]; then
        if [ -d "$PROJECT_DIR/.git" ]; then
            cd $PROJECT_DIR
            echo ""
            echo $PROJECT_DIR
            originIsLaFouchette $dir
            disablingPushOnOrigin $dir
            addingUpstream $dir
            addingRemoteForCurrentUser $dir
            settingHooks $PROJECT_DIR
            fetchAll
            currentBranch

        fi
    fi
done
cd $PWD_BACK

#git config --global --replace-all push.default $CURRENT_USER
#yellify "Default push set to $CURRENT_USER"
