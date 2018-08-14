resource "aws_instance" "firstMachine"
{
 ami= "ami-ba602bc2"
 instance_type = "t2.micro"

 tags {
	Name = "Terraform-testMachine"
}
}

