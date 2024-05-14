# Overview
    This Terraform script provisions and manages a simple nginx web server an AWS EC2 instance. It includes a VPC, subnets, a NAT Gateway, security groups, an EC2 instance running Docker with a web application, and an Application Load Balancer.

    Choices Made
    AWS Region: Chosen eu-west-2 for the example.
    AMI: Used Amazon Linux 2 AMI for the EC2 instance.
    Instance Type: Selected t2.micro for cost efficiency during testing and development.
    Subnets: Configured 2 public and one private subnet for the purposes of this exercise. In a production environment an additonal private subnet in an alternate AZ is advised for better isolation and security. Having 2 public subnets in alternate zones is also a requirement for the ALB.
    NAT Gateway: Used one NAT Gateways for this exercise, however to ensure high availability in a production environment this should be scales to 2 for additonal resiliency.
    Load Balancer: I have used HTTP which is not recommended/best practice. As this is a non-prod/lab exercises, setting up a TLS certificate and DNS public zone has a cost associated and is out of scope.


 # set your AWS credentials

 export AWS_ACCESS_KEY_ID=your_access_key_id
 export AWS_SECRET_ACCESS_KEY=your_secret_access_key
 export AWS_SESSION_TOKEN=your_session_token  -  required if you are using temporary credentials.

 # build docker
 docker build -t terraform-aws-orbs:0.1 .

 # apply terrafrom
 docker run --rm -v $(pwd)/.state:/app/.state -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY  -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN terraform-aws-orbs:0.1

 # destroy terrafrom
 docker run --rm -v $(pwd)/.state:/app/.state -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY  -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN terraform-aws-orbs:0.1 destroy
  
 # delete docker container  
 docker rm terraform-aws-container 

 # Pre-commit hooks
  Husky is install which runs tflint and tfsec on the terrafom directory prior to commiting and pushing the code to the repository.


# design decisions
  Considerations for Using One Subnet

    Development and Testing: For non-critical environments, such as development or testing, where high availability is not a concern, using a single subnet might be acceptable. This can simplify the architecture and reduce costs.
    Cost Constraints: If cost is a significant constraint, minimizing the number of subnets and AZs can help reduce charges,
