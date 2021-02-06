#!/bin/bash
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php -y
sudo mkdir -p /var/www/html/
sudo chown -R ubuntu:ubuntu /var/www/html/
sudo echo -e "<?php \nphpinfo(); \n" >> /var/www/html/index.php
exit
