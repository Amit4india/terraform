# Adding provider name
provider "aws"
{
	region = "us-west-2"

}


resource "aws_instance" "firstMachine"
{
 ami= "ami-0bbe6b35405ecebdb"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["${aws_security_group.terraformAccess.id}"]
 key_name="Ansibletest"
 
 # Add basic server for test
 user_data = <<-EOF
            #!/ bin/ bash
            echo "Hello, World" > index.html
            nohup busybox httpd -f -p "${ var.server_port}" &
            EOF


 tags {
	Name = "Terraform-testMachine"
}

}

resource "aws_security_group" "terraformAccess"
{
	name= "Terraform example access"
	ingress {
 		  from_port = "${var.server_port}"
   		  to_port   = "${var.server_port}"
                  protocol  = "tcp"
                  cidr_blocks = ["0.0.0.0/0"]

		}
	ingress {
		  from_port = 22
                  to_port   = 22
                  protocol  = "tcp"
                  cidr_blocks =["0.0.0.0/0"]
		}

  egress {
      to_port = 0
                from_port =0
                protocol  = "-1"
                cidr_blocks=["0.0.0.0/0"]

  }
}

variable "server_port"
{
 	 description = "The port of server on which server listen"
  	default = 80
}

output "ipaddress"
{
	value = "${aws_instance.firstMachine.public_ip}"
}
