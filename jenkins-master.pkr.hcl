# Packer configuration block
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Source block defines the Amazon EBS source configuration
source "amazon-ebs" "jenkins-master" {
  ami_name      = "jenkins-master-ubuntu-20.04"
  instance_type = "t2.micro"
  region        = "us-east-1"

  # Filters to find the Ubuntu 20.04 AMI
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]  # Canonical's AWS account ID
  }

  ssh_username = "ubuntu"  # SSH username for connecting to the instance
}

# Build block defines the build process
build {
  name    = "jenkins-master-ubuntu-20.04"  # Name of the build process
  sources = ["source.amazon-ebs.jenkins-master"]  # References the source configuration

  # Provisioner to execute shell script
  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S env {{ .Vars }} {{ .Path }}"  # Command to execute the script
    script          = "jenkins-master-script.sh"  # Path to the shell script
    pause_before    = "10s"  # Pause before executing the script
  }
}
