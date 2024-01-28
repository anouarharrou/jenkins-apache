# DevOps Setup Repository


This repository provides a streamlined solution for setting up a robust DevOps environment on Ubuntu, leveraging Jenkins for continuous integration, Apache as a reverse proxy for a custom domain, and Ansible for automation. The setup includes the generation of a self-signed SSL certificate to ensure secure communication.

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

