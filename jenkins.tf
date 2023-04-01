module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group para o servidor do Jenkins Server"
  vpc_id      = "vpc-0251a96268b114b94"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}


module "jenkins_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = "Jenkins-Server"
  ami                    = "ami-00c39f71452c08778"
  instance_type          = "t3.micro"
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [module.jenkins_sg.security_group_id]
  subnet_id              = "subnet-090f382b2717544d8"
 user_data 	= file ("./dependencias.sh")
  iam_instance_profile   = "LabInstanceProfile"

  tags = {
    Terraform = "true"
  }
}

resource "aws_eip" "jenkins-ip" {
  instance = module.jenkins_ec2_instance.id
  vpc      = true
}

