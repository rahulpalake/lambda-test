#!/usr/bin/env bash

# Deploys the Lambda .zip file to AWS Lambda as version $LATEST

set -e

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
zip_file="$script_dir/../target/greeting-lambda.zip"
#lambda_name=GreetingLambda
runtime="nodejs4.3"
rolearn="arn:aws:iam::718536893313:role/lambda_firmware_upgrade_role"
lambda_name=$1
operation=$2

if [ -z "$2" ]
  then
    lambda_name=GreetingLambda
fi



if [ -z "$AWS_DEFAULT_REGION" ]; then
    aws_region="us-west-2"
else
    aws_region=$AWS_DEFAULT_REGION
fi

if [[ "$operation" == "update" ]]; then
	aws lambda update-function-code --function-name $lambda_name --zip-file fileb://$zip_file --region $aws_region
fi

if [[ "$operation" == "create" ]]; then
	aws lambda create-function --function-name $lambda_name --zip-file fileb://$zip_file --region $aws_region --runtime $runtime --role $rolearn --handler index.handler
fi


