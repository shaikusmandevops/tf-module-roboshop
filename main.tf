resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  security_groups = var.security_groups

  tags = {
    Name = var.name
  }
}
resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = "${var.name}.usmandevops.online"
  type    = "A"
  ttl     = 30
  records =  [aws_instance.instance.private_ip]
}

resource "null_resource" "ansible" {
  depends_on = [
                  aws_route53_record.record
  ]
  provisioner "local-exec" {
    command = <<EOF
        cd /home/ansible/roboshop-ansible
        git pull
        sleep 30
        ansible-playbook -i ${var.name}-dev.usmandevops.online, main.yml -e ansible_ssh_user=centos -e ansible_ssh_private_key_file=/root/auth_file/usmanppk.pem -e component=${var.name}
    EOF
  }
}



