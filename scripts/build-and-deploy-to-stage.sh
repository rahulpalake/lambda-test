#!/usr/bin/env bash

# Tests, packages, deploys, to DEV alias, etc...
# Usage:
#   build-and-deploy-to-dev.sh build_number

set -e

cd "$( dirname "${BASH_SOURCE[0]}" )"

build_number=$1
lambda_name=$2
operation=$3
aliasname=$4

#echo $lambda_name
#exit 1

echo -e "\n==================== Execute Tests =============================\n"
./1-test.sh

echo -e "\n==================== Package Files =============================\n"
./2-package.sh

echo -e "\n==================== Deploy Lambda =============================\n"
./3-update-lambda.sh $lambda_name $operation

#echo -e "\n==================== Execute Integration Tests =================\n"
#./4-integration-test.sh

echo -e "\n==================== Publish Lambda Version ====================\n"
./5-publish-version.sh $build_number $lambda_name

echo -e "\n==================== Update ${alias} Lambda Alias ===================\n"
./6-update-stage-alias.sh $build_number $lambda_name $aliasname