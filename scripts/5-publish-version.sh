#!/usr/bin/env bash

# Publishes the version $LATEST Lambda with the build number as description
#
# Usage:
#   5-publish-version.sh build_number

set -e

#lambda_name=GreetingLambda
lambda_name=$2
build_number=$1

if [ -z "$AWS_DEFAULT_REGION" ]; then
    aws_region="us-west-2"
else
    aws_region=$AWS_DEFAULT_REGION
fi

aws lambda publish-version --function-name $lambda_name --description $build_number --region $aws_region