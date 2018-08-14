resource "aws_instance" "firstMachine"
{
 ami= "ami-ba602bc2"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["${aws_security_group.terraformAccess.id}"]

 user_data =<<-EOF
        #! /bin/bash
        echo "Hello World" > index.html
        nohup busybox httpd -f -p 8080 &
        EOF

 tags {
	Name = "Terraform-testMachine"
}

}

resource "aws_security_group" "terraformAccess"
{
	name= "Terraform example access"
	ingress {
 		  from_port = 8080
   		  to_port   = 8080
                  protocol  = "tcp"
                  cidr_blocks = ["0.0.0.0/0"]

		}
}

