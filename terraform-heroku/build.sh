export APP_NAME=deloitte-butter
CREATE_TOKEN=false

heroku login
  EMAIL=$(heroku whoami)
if [[ "${CREATE_TOKEN}" == "true" ]]
  AUTH=$(heroku authorizations:create --description $APP_NAME)
  TOKEN=$(echo $AUTH | sed 's/.*Token:\s*//'| cut -f 1 -d ' ')
else
  AUTH=$(heroku authorizations | grep $APP_NAME)
  TOKEN=$(echo $AUTH | cut -f 2 -d ' ')
fi


heroku create $APP_NAME
export HEROKU_API_KEY= $TOKEN
export HEROKU_EMAIL=$EMAIL
terraform init
terraform apply -var example_app_name=$APP_NAME
terraform plan -var example_app_name=$APP_NAME -out=current.tfplan
terraform apply current.tfplan
