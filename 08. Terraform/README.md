# Terraform Tasks

1. Create a basic .tf which launches an EC2 AWS instance.
2. Update the existing configuration by adding:
	* A data block for AMI to avoid hardcoding;
	* Dependencies to attach an EC2 instance to a created security group;
	* Variables & create an output, that shows the EC2 public IP after deployment.
3. Modify the configuration with:
	* A built-in function (e.g. filebase64 for ec2 userdata);
	* Dynamic block/s.
	