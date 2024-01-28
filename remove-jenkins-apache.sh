#!/bin/bash

# Stop Jenkins and Apache if they are running
sudo systemctl stop jenkins
sudo systemctl stop apache2

# Remove Jenkins
sudo apt-get remove --purge jenkins
sudo rm -rf /var/lib/jenkins
sudo rm -rf /etc/default/jenkins

# Remove Apache
sudo apt-get remove --purge apache2
sudo apt-get autoremove
sudo rm -rf /etc/apache2


echo "Jenkins and Apache removed successfully."
