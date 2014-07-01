#!/bin/bash

# Configure reviewboard database
/usr/bin/mysqld_safe &
sleep 5
mysql -u root mysql -e "GRANT ALL PRIVILEGES ON *.* TO $RB_USER@localhost IDENTIFIED BY '$RB_USER'; FLUSH PRIVILEGES;"
mysql -u $RB_USER -p$RB_USER -e "CREATE DATABASE reviewboard CHARACTER SET = 'utf8'"

# Condfigure reviewboard site
mkdir /etc/reviewboard
chown $RB_USER:$RB_USER /etc/reviewboard
rb-site install \
    --noinput \
    --domain-name=localhost \
    --site-root=/ \
    --media-url=media \
    --db-type=mysql \
    --db-name=$RB_USER \
    --db-user=$RB_USER \
    --db-pass=$RB_USER \
    --cache-type=file \
    --cache-info=/home/$RB_USER/devel/htdocs/reviewboard/cache \
    --web-server-type=apache \
    --python-loader=wsgi \
    --admin-user=admin \
    --admin-password=password \
    --admin-email=admin@example.com \
    /home/$RB_USER/devel/htdocs/reviewboard

# Shutdown database
mysqladmin -u root shutdown

