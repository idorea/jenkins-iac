terraform {
        backend "s3" {
         bucket = "idorea-vorx-terraform"
         key = "jenkins-server.tfstates"
         region = "us-east-1"
        }
}

