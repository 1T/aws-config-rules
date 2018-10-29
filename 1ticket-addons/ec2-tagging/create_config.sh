#! /bin/bash

aws cloudformation deploy \
    --region us-east-1 \
    --profile $AWS_PROFILE \
    --capabilities CAPABILITY_IAM \
    --stack-name required-tags-config \
    --template-file config_required_tags.json 
