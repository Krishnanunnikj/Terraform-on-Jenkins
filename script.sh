#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo echo "Hi Krishna" >/var/www/html/index.nginx-debian.html