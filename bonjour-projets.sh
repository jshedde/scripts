#!/bin/bash

CURRENT_USER=jshedde

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
    git fetch --all 2>/dev/null >/dev/null
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

    CURRENT_USER_REMOTE=`git remote -v | grep ":$CURRENT_USER/" -c`
    if [ $CURRENT_USER_REMOTE -eq 0 ]; then
        git remote add $CURRENT_USER git@github.com:$CURRENT_USER/$PROJECT.git
        yellify "Adding remote $CURRENT_USER"
    fi
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
            if [ $dir == "lafourchette-core" ]; then
            originIsLaFouchette $dir
            fetchAll
            fi

        fi
    fi
done
cd $PWD_BACK

#git config --global --replace-all push.default $CURRENT_USER
#yellify "Default push set to $CURRENT_USER"
