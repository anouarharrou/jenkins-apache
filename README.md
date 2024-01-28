# DevOps Setup Repository


This repository contains scripts to set up a DevOps environment with Jenkins, Apache, and Ansible on Ubuntu.


## Installation

1. Clone this repository:

```bash
git clone https://github.com/anouarharrou/jenkins-ansible-roles.gitt
cd jenkins-ansible-roles
```
Make it executable:

```bash
chmod +x install-jenkins-apache.sh
```

2. Run the setup script:

```bash
./install-jenkins-apache.sh yourdomain.com
```
    
Replace yourdomain.com with your actual domain.

Follow the prompts to configure Jenkins, generate SSL certificates, and set up Apache.

Optionally, you can choose to install Ansible during the setup.

## Removal

To remove Jenkins and Apache, run the removal script:

```bash
./remove-jenkins-apache.sh
```

This script will stop Jenkins and Apache, remove the packages, and clean up configuration files.

