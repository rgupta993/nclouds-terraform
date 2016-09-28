
module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc?ref=v1.0.0"

  name = "ecs-vpc"

  cidr = "10.0.0.0/16"
  private_subnets = "10.0.16.0/24,10.0.17.0/24"
  public_subnets  = "10.0.101.0/24,10.0.102.0/24"

  azs = "us-east-1b,us-east-1c"
}
