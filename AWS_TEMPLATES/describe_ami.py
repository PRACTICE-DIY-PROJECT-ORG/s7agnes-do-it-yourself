import boto3

# Initialize the EC2 client
ec2_client = boto3.client('ec2')

# AMI ID to check
ami_id = 'ami-0ea1d45dcdd47edf6'

# Describe the image to get its details
def describe_image(image_id):
    try:
        response = ec2_client.describe_images(ImageIds=[image_id])
        return response['Images'][0]['ImageLocation']
    except Exception as e:
        return str(e)

# Fetch and print the AMI details
ami_details = describe_image(ami_id)
print("AMI Details:", ami_details)

