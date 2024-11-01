#!/bin/bash

apt-get update

apt-get install -y apache2

apt-get install -y software-properties-common

add-apt-repository ppa:ondrej/php
apt-get update

apt-get install -y php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-xml php8.2-mbstring php8.2-curl php8.2-intl libapache2-mod-php8.2

apt-get install -y certbot python3-certbot-apache

apt-get insall -y mysql-client-core-8.0
apt-get install composer

systemctl enable apache2
systemctl start apache2


sudo certbot --apache -d api.partneraX.eu


systemctl restart apache2
