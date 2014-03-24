#!/bin/bash

WORKSPACE=/var/www
PWD_BACK=$PWD
for dir in `ls $WORKSPACE`
do
    PROJECT_DIR=$WORKSPACE/$dir
    if [ -d $PROJECT_DIR ]; then
        if [ -f "$PROJECT_DIR/composer.json" ]; then
            cd $PROJECT_DIR
            echo -e "\n===$dir===\n"
            /home/vagrant/bin/composer.phar install
        fi
    fi
done
cd $PWD_BACK
