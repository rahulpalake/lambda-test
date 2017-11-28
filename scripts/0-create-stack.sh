#!/usr/bin/env bash

# Creates the stack

set -e

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
template_file="$script_dir/../cloudformation.template"
stack_name=greeting-stack

if [ -z "$AWS_DEFAULT_REGION" ]; then
    aws_region="us-west-2"
else
    aws_region=$AWS_DEFAULT_REGION
fi

aws cloudformation create-stack --stack-name $stack_name --template-body fileb://"$template_file" --capabilities CAPABILITY_IAM --region $aws_region
