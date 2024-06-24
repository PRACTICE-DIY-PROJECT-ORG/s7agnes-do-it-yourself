#!/bin/bash

# Variables
LAUNCH_TEMPLATE_NAME="MyLaunchTemplate"
VERSION_DESCRIPTION="Version1"
IMAGE_ID="ami-0ea1d45dcdd47edf6" # Replace with your valid AMI ID
INSTANCE_TYPE="t2.micro"
KEY_NAME="admin_test_key_pair" # Replace with your key pair name
SECURITY_GROUP_ID="sg-07533a7ebb930401e" # Use the specified security group
INSTANCE_TAG="aws-template-ec2"
REGION="us-east-1"

# Create Launch Template
echo "Creating launch template..."
create_output=$(aws ec2 create-launch-template \
    --region $REGION \
    --launch-template-name $LAUNCH_TEMPLATE_NAME \
    --version-description $VERSION_DESCRIPTION \
    --launch-template-data "{
        \"ImageId\":\"$IMAGE_ID\",
        \"InstanceType\":\"$INSTANCE_TYPE\",
        \"KeyName\":\"$KEY_NAME\",
        \"SecurityGroupIds\":[\"$SECURITY_GROUP_ID\"],
        \"TagSpecifications\":[{\"ResourceType\":\"instance\",\"Tags\":[{\"Key\":\"Name\",\"Value\":\"$INSTANCE_TAG\"}]}]
    }" 2>&1)

if echo "$create_output" | grep -q 'Invalid'; then
    echo "Error creating launch template: $create_output"
    exit 1
else
    echo "Launch template created successfully."
fi

# Wait for a few seconds to ensure the launch template is created
sleep 5

# Launch Instance from Launch Template
echo "Launching instance from launch template..."
launch_output=$(aws ec2 run-instances \
    --region $REGION \
    --launch-template LaunchTemplateName=$LAUNCH_TEMPLATE_NAME,Version=1 \
    --count 1 2>&1)

if echo "$launch_output" | grep -q 'InvalidLaunchTemplateName.NotFound'; then
    echo "Error launching instance: $launch_output"
    exit 1
else
    echo "Instance launched successfully."
fi
