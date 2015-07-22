#!/bin/bash

if [ $(grep -c ';zend_extension' /etc/php5/conf.d/xdebug.ini) -eq 1 ]; then
    echo "Enabling Xdebug"
    sed -i 's/;zend_extension/zend_extension/' /etc/php5/conf.d/xdebug.ini
else
    echo "Disabling Xdebug"
    sed -i 's/zend_extension/;zend_extension/' /etc/php5/conf.d/xdebug.ini
fi
