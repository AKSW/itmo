#!/bin/sh

ITMO_DIR=$(dirname $(pwd))
BIN_DIR=$ITMO_DIR/bin
CRONTAB_LOG_DIR=$ITMO_DIR/crontab/log

cp cron.tab.templ cron.tab
sed -i "s#BIN_DIR#$BIN_DIR#g" cron.tab
sed -i "s#CRONTAB_LOG_DIR#$CRONTAB_LOG_DIR#g" cron.tab

sudo crontab cron.tab
