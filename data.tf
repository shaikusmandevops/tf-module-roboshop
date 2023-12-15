data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}
#output "aws_ami_data" {
#  value = data.aws_ami.ami
#}