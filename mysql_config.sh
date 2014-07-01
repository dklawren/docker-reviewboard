#!/bin/bash

# Configure reviewboard database
rm -rf /etc/mysql
rm -rf /var/lib/mysql/*
/usr/bin/mysql_install_db --user=$RB_USER --basedir=/usr --datadir=/var/lib/mysql

