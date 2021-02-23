# AWS EC2 Region
# default: 'us-east-1'
# @see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions
aws_region = "us-west-2"

# AWS EC2 Availability Zone
# default: 'us-east-1a'
# @see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#using-regions-availability-zones-launching
availability_zones = "us-west-2b"

# AWS EC2 Key Pair
# @see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
key_name = "vault_deploy_key2"

# Specify a name here to tag all instances
# default: 'learn-vault-raft_storage'
environment_name = "vault-deployment"
