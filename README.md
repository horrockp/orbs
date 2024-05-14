# Terraform AWS Infrastructure Setup

## Description

This Terraform configuration sets up the following AWS infrastructure:
- A VPC with public and private subnets.
- A NAT Gateway for internet access from the private subnet.
- Security groups for the EC2 instance and load balancer.
- An EC2 instance running a Docker container with a simple web application (nginx).
- An Application Load Balancer (ALB) to route traffic to the EC2 instance.

## Prerequisites

- Terraform installed on your local machine.
- AWS CLI configured with appropriate access.

## Usage

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd terraform-aws-setup

