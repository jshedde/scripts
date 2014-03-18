#!/bin/bash

WORKSPACE=/var/www
PWD_BACK=$PWD
for dir in `ls $WORKSPACE`
do
    PROJECT_DIR=$WORKSPACE/$dir
    if [ -d $PROJECT_DIR ]; then
        if [ -d "$PROJECT_DIR/.git" ]; then
            cd $PROJECT_DIR
            CURR_BR=`git branch  2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
#            echo -e "$CURR_BR\t $dir"
            echo -e "$dir\t\t$CURR_BR"

        fi
    fi
done
cd $PWD_BACK
