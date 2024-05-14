FROM hashicorp/terraform:latest

# Install necessary packages
RUN apk add --no-cache curl

# Create application directory
RUN mkdir /app

# Add Terraform configuration files to the container
COPY terraform/alb.tf /app/alb.tf
COPY terraform/provider.tf /app/provider.tf
COPY terraform/vpc.tf /app/vpc.tf
COPY terraform/nat-gateway.tf /app/nat-gateway.tf
COPY terraform/outputs.tf /app/outputs.tf
COPY terraform/ec2.tf /app/ec2.tf
COPY terraform/security-groups.tf /app/security-groups.tf
COPY terraform/variables.tf /app/variables.tf
COPY terraform/iam.tf /app/iam.tf
COPY terraform/entrypoint.sh /app/entrypoint.sh


# Create Terraform state directory
RUN mkdir /app/.state
VOLUME /app/.state

WORKDIR /app

# Make the entrypoint script executable
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]