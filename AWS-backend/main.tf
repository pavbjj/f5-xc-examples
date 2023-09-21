resource "volterra_aws_vpc_site" "aws_site" {
  name       = "p-kuligowski-crawford-tf"
  namespace  = "system"
  aws_region = "us-east-1"

  default_blocked_services = true

  aws_cred {
    name      = "my-creds"
    namespace = "system"
    tenant    = "mytenant-prqnkato"
  }

  vpc {
    vpc_id = "vpc-x"
  }


  ingress_egress_gw {
    allowed_vip_port {
      use_http_port = true
    }

    aws_certified_hw = "aws-byol-multi-nic-voltmesh"

    az_nodes {
      aws_az_name = "us-east-1a"
      disk_size   = "80"

      workload_subnet {
        existing_subnet_id = "subnet-y"
      }
      outside_subnet {
        existing_subnet_id = "subnet-w"
      }
      inside_subnet {
        existing_subnet_id = "subnet-z"
      }
    }
    performance_enhancement_mode {
      perf_mode_l7_enhanced = true
    }
  }

  custom_security_group {
    outside_security_group_id = "sg-1"
    inside_security_group_id  = "sg-2"
  }

  direct_connect_disabled = true
  instance_type           = "t3.xlarge"
  disable_internet_vip    = true
  logs_streaming_disabled = true
  ssh_key       = "ssh-rsa "
}

