#!/bin/bash

# INSTALAR ANSIBLE

sudo add-apt-repository -uy ppa:ansible/ansible
sudo apt-get install -y ansible

# INSTALAR ICINGA2

ansible-playbook master.yml -K -i hosts
