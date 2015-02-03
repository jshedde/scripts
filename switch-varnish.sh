#!/bin/bash
VARNISH=/etc/varnish/default.vcl

if [ ! -f $VARNISH.preprod ]; then
    echo "Retrieving current preprod configuration"
    scp lafourchette@web1-core.preprod.lafourchette.typhon.net:/etc/varnish/default.vcl /etc/varnish/default.vcl.preprod
fi
if [ ! -f $VARNISH.local ]; then
    echo "Backuping current varnish configuration as local configuration"
    cp $VARNISH $VARNISH.local
fi

if [ `file $VARNISH | grep -c local` -eq 1 ]; then
    TOSWITCH=preprod
else
    TOSWITCH=local
fi

rm -f $VARNISH
ln -s $VARNISH.$TOSWITCH $VARNISH

echo "Switching to $TOSWITCH"

service varnish restart
