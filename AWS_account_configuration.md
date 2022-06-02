# AWS account configuration


## 1. IAM configuration
The IAM configuration depends on how you created you AWS account (regular Account or SingleSignOn Account)

### 1.1 Regular account
* **Administrators:** already defined permissions policies (Billing and AdministratorAccess)
* **LithopsUserGroup:** create a new group named "LithopsUserGroup" with the folling permission policies:
  * AmazonEC2ContainerRegistryFullAccess - administrated by client
  * IAMGetRole - administrated by client
  * AmazonEC2FullAccess - administrated by AWS
  * AmazonEC2ContainerRegistryFullAccess - administrated by AWS
  * AmazonS3FullAccess - administrated by AWS
  * AmazonVPCFullAccess - administrated by AWS
  * AWSLambda_FullAccess - administrated by AWS
  * STSFullAccess - inserted client



### 1.2 SSO account
Create a new "lithops-group" with the following "lithops-policy", and create new users in order to get *ACCESS_KEY_ID* and *SECRET_ACCESS_KEY* for the lithops configuration file.

```json
LITHOPS POLICY
{
    "Version": "<DATE>",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "batch:CreateComputeEnvironment",
                "ecs:TagResource"
            ],
            "Resource": [
                "arn:aws:batch:*:XXXXXXXXXXXXXX:compute-environment/*",
                "arn:aws:ecs:*:*:task/*_Batch_*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ec2:CreateTags",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:CreateAction": "RunInstances"
                }
            }
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": [
                        "ec2.amazonaws.com",
                        "ec2.amazonaws.com.cn",
                        "ecs-tasks.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com",
                        "autoscaling.amazonaws.com",
                        "ecs.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Sid": "VisualEditor4",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "logs:DeleteSubscriptionFilter",
                "ecs:StartTask",
                "ecs:DescribeTaskDefinition",
                "logs:CreateLogStream",
                "ec2:ModifySpotFleetRequest",
                "autoscaling:DescribeAutoScalingGroups",
                "ecs:RegisterTaskDefinition",
                "logs:CancelExportTask",
                "logs:DeleteRetentionPolicy",
                "autoscaling:UpdateAutoScalingGroup",
                "ec2:DescribeAccountAttributes",
                "ecs:StopTask",
                "ec2:DescribeKeyPairs",
                "ecs:DeregisterContainerInstance",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ecs:ListTaskDefinitions",
                "autoscaling:PutNotificationConfiguration",
                "iam:GetRole",
                "autoscaling:SetDesiredCapacity",
                "ecs:CreateCluster",
                "ec2:RunInstances",
                "ecs:DeleteCluster",
                "autoscaling:SuspendProcesses",
                "logs:DeleteQueryDefinition",
                "logs:CreateLogGroup",
                "ec2:DescribeVpcClassicLink",
                "ecs:DescribeClusters",
                "logs:CreateLogDelivery",
                "logs:PutMetricFilter",
                "autoscaling:CreateOrUpdateTags",
                "logs:UpdateLogDelivery",
                "ec2:DescribeImageAttribute",
                "ec2:*",
                "autoscaling:DeleteAutoScalingGroup",
                "ecs:ListContainerInstances",
                "logs:PutSubscriptionFilter",
                "ec2:DescribeSubnets",
                "autoscaling:CreateAutoScalingGroup",
                "autoscaling:DescribeAutoScalingInstances",
                "ec2:CancelSpotFleetRequests",
                "ec2:DescribeInstanceAttribute",
                "autoscaling:DescribeLaunchConfigurations",
                "ec2:RequestSpotFleet",
                "ec2:DescribeSpotInstanceRequests",
                "logs:DeleteLogStream",
                "ec2:DescribeSpotPriceHistory",
                "ecs:DeregisterTaskDefinition",
                "logs:CreateExportTask",
                "iam:PassRole",
                "logs:DeleteMetricFilter",
                "batch:*",
                "ecs:RunTask",
                "autoscaling:DescribeAccountLimits",
                "ecs:ListTasks",
                "logs:DeleteLogDelivery",
                "logs:AssociateKmsKey",
                "ecs:DescribeContainerInstances",
                "ecs:DescribeTasks",
                "logs:PutDestination",
                "ec2:DescribeInstanceStatus",
                "ecs:ListClusters",
                "logs:DisassociateKmsKey",
                "ec2:DeleteLaunchTemplate",
                "ec2:TerminateInstances",
                "logs:DescribeLogGroups",
                "iam:GetInstanceProfile",
                "s3:*",
                "logs:DeleteLogGroup",
                "logs:PutDestinationPolicy",
                "ec2:DescribeLaunchTemplateVersions",
                "sts:*",
                "logs:DeleteDestination",
                "logs:PutQueryDefinition",
                "logs:PutLogEvents",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSpotFleetRequests",
                "autoscaling:CreateLaunchConfiguration",
                "ec2:DescribeImages",
                "ecs:ListAccountSettings",
                "ec2:DescribeSpotFleetInstances",
                "ec2:CreateLaunchTemplate",
                "autoscaling:DeleteLaunchConfiguration",
                "ecs:ListTaskDefinitionFamilies",
                "ecs:UpdateContainerAgent",
                "lambda:*",
                "ecr:*",
                "logs:PutRetentionPolicy"
            ],
            "Resource": "*"
        }
    ]
}
```

### 2. Roles
Then you must create 2 roles with the configuration previously shown (lithops-policy), in this way the ARNs for the configuration of lithops will be obtained:
* lithops-role
* lithops-role-ec2

## 2. Account configuration
* Remember to place all your ressourcers alway in the same zona (e.g. 'us-east-1'), to avoid communication costs
* Remove concurrent execution limit for lambda functions (default set to 50 concurrent executions)


