# Evaluate our AWS Configuration 

## AWS Config

AWS Config is a service that enables you to assess, audit, and evaluate the configurations of your AWS resources. Config continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired configurations. With Config, you can review changes in configurations and relationships between AWS resources, dive into detailed resource configuration histories, and determine your overall compliance against the configurations specified in your internal guidelines. This enables you to simplify compliance auditing, security analysis, change management, and operational troubleshooting.

## Required app-name tag

All of the 1Ticket AWS resources must be created with the *app-name* tag.  We use that tag for the following purpposes:

* To determine the total cost associated with an application
* To validate that a resource was created by us

## Rules to check for required tags

We use AWS Config to verify that the resources we create are tagged with the tag *app-name*.  We're using the built in AWS Config rule [required-tags](https://docs.aws.amazon.com/config/latest/developerguide/required-tags.html) to check on the resources of type:

* DynamoDB::Table
* EC2::Instance
* RDS::DBInstance

To install the *required-tags* AWS Config rule, do the following

```
# checkout this repo
# change directory to 1ticket-addons\ec2-tagging
# set AWS_PROFILE to the account desired
export AWS_PROFILE=dtiprod
./create_config.sh
```


In addition, we are using the [AWS Labs provided custom tagging rule](https://github.com/awslabs/aws-config-rules/blob/master/python/lambda_require_tags_with_valid_values.py) to check for the *app-name* tag on AWS::Lambda::Function resources. To use the custom tagging rule, we use the [AWS Rule Development Kit](https://github.com/awslabs/aws-config-rdk) to deploy the rule

```
# checkout this repo
# change directory to 1ticket-addons
pip install rdk
rdk -r dtiprod lambda-tagging
```

## Notifications

Once the rules are enabled, when a resource of the types above are created or updated without the *app-name* tag, an email notification will be sent to the email list <TBD>
  
## Cost

[AWS Config cost](https://aws.amazon.com/config/pricing/) is determined from the number of rules and the number of configuration items.  The cost associated with rules is about 4 rules x $2 = $8 per month.  The number of configuration items is determined from the number of changes to a resource type that AWS Config is monitoring.  We are expecting a cost of less than $20 for the dtiprod account, and slightly more for a larger account such as dti1ticketprod
