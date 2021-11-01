#!/usr/bin/env bash

while [ $# -gt 0 ]; do
  case $1 in
    --app-name | -n )
    shift
    APP_NAME=$1
    ;;
    --create-token | -c )
    shift
    CREATE_TOKEN=$1
    ;;
  esac
  shift
done

export APP_NAME="${APP_NAME:-replacement-butter}"
CREATE_TOKEN="${CREATE_TOKEN:-false}"

heroku login
EMAIL=$(heroku whoami)
if [[ "${CREATE_TOKEN}" == "true" ]]; then
  AUTH=$(heroku authorizations:create --description $APP_NAME)
  TOKEN=$(echo $AUTH | sed 's/.*Token:\s*//'| cut -f 1 -d ' ')
else
  AUTH=$(heroku authorizations | grep $APP_NAME)
  TOKEN=$(echo $AUTH | cut -f 2 -d ' ')
fi

export HEROKU_API_KEY=$TOKEN
export HEROKU_EMAIL=$EMAIL
terraform init
terraform apply -var app_name=$APP_NAME
terraform plan -var app_name=$APP_NAME -out=current.tfplan
terraform apply current.tfplan
