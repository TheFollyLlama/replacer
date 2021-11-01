#!/usr/bin/env bash

#Install Heroku for ubuntu
#https://devcenter.heroku.com/articles/heroku-cli
sudo snap install --classic heroku

#Install Terraform for ubuntu
#https://learn.hashicorp.com/tutorials/terraform/install-cli
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
