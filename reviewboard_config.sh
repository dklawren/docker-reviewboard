#!/bin/bash

# Install reviewboard
yum remove -y ReviewBoard
easy_install reviewboard
easy_install RBTools

# Configure reviewboard database
/usr/bin/mysqld_safe &
sleep 5
mysql -u root mysql -e "GRANT ALL PRIVILEGES ON *.* TO $RB_USER@localhost IDENTIFIED BY '$RB_USER'; FLUSH PRIVILEGES;"
mysql -u $RB_USER -p$RB_USER -e "CREATE DATABASE reviewboard CHARACTER SET = 'utf8'"

# Condfigure reviewboard site
mkdir /etc/reviewboard
chown $RB_USER:$RB_USER /etc/reviewboard
rb-site install \
    --copy-media \
    --noinput \
    --domain-name=localhost:8080 \
    --site-root=/ \
    --static-url=static/ \
    --media-url=media/ \
    --db-type=mysql \
    --db-name=$RB_USER \
    --db-host=localhost \
    --db-user=$RB_USER \
    --db-pass=$RB_USER \
    --cache-type=memcached \
    --cache-info=memcached://localhost:11211 \
    --web-server-type=apache \
    --web-server-port=80 \
    --python-loader=wsgi \
    --admin-user=admin \
    --admin-password=password \
    --admin-email=admin@example.com \
    --sitelist=/etc/reviewboard/sites \
    /home/$RB_USER/devel/htdocs/reviewboard

# Shutdown database
mysqladmin -u root shutdown

