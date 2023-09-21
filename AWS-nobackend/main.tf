
resource "volterra_aws_vpc_site" "site" {
  name       = "my-vpc-site-tf"
  namespace  = "system"
  aws_region = "us-east-1"

  aws_cred {
    tenant    = "f5-tenant"
    namespace = "system"
    name      = "mycreds-f5"
  }
  instance_type = "t3.xlarge"
  ssh_key       = "ssh-rsa"

  vpc {
    vpc_id = "vpc-x"
  }
  ingress_egress_gw {
    aws_certified_hw = "aws-byol-multi-nic-voltmesh"
    az_nodes {
      aws_az_name = "us-east-1a"
      workload_subnet {
        existing_subnet_id = "subnet-x"
      }
      outside_subnet {
        existing_subnet_id = "subnet-y"
      }
      inside_subnet {
        existing_subnet_id = "subnet-z"
      }
    }
  }
  logs_streaming_disabled = true
  no_worker_nodes         = true
}


