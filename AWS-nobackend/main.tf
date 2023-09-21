# Setup VPCs, subnets, route tables, and routes
# module "m_VPC_Primary" {
#   source           = "./modules/aws/infra/vpc" # 'modules' is copied by the build pipeline from the centralized module repo.
#   Resource_Network = var.VPC_Primary
#   Tags             = var.VPC_Primary.Tags.Primary
# }
/*
module "m_VPC_Secondary" {
  providers = {
    aws = aws.secondary # We want to create resources in another region so we need to pass the required provider explicitly.
  }
  source           = "./modules/aws/infra/vpc" # 'modules' is copied by the build pipeline from the centralized module repo.
  Resource_Network = var.VPC_Secondary
  Tags             = var.VPC_Secondary.Tags.Primary
}
*/

# For F5 distributed cloud
/*
resource "volterra_cloud_credentials" "aws_cred" {
  name      = format("%s-cred", var.site_name)
  namespace = "system" # Required to be "system" regardless of other namespaces in use for other F5 configurations
  aws_secret_key {
    access_key = var.aws_access_key
    secret_key {
      clear_secret_info {
        url = format("string:///%s", var.b64_aws_secret_key)
      }
    }
  }
}
*/

resource "volterra_aws_vpc_site" "site" {
  name       = "p-kuligowski-poc-tf"
  namespace  = "system"
  aws_region = "us-east-1"
  /*
  aws_cred {
    name      = volterra_cloud_credentials.aws_cred.name
    namespace = "system"
  }
  */
  aws_cred {
    tenant    = "f5-tenant"
    namespace = "system"
    name      = "mycreds-f5"
  }
  instance_type = "t3.xlarge"
  ssh_key       = "ssh-rsa"
  vpc {
    /*
    new_vpc {
      name_tag     = var.site_name
      primary_ipv4 = var.aws_vpc_cidr
    }
    */
    vpc_id = "vpc-x"
  }
  ingress_egress_gw {
    aws_certified_hw = "aws-byol-multi-nic-voltmesh" # "aws-byol-voltmesh"
    az_nodes {
      aws_az_name = "us-east-1a"
      # disk_size = 0
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
  /*
  ingress_gw {
    az_nodes {
      aws_az_name = var.aws_az
      disk_size   = 20
      local_subnet {
        subnet_param {
          ipv4 = var.outside_subnet_cidr_block
        }
      }
    }
  }
  */
  logs_streaming_disabled = true
  no_worker_nodes         = true
}

/*
resource "volterra_tf_params_action" "apply_aws_vpc" {
  site_name        = volterra_aws_vpc_site.site.name
  site_kind        = "aws_vpc_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = true
}
*/
