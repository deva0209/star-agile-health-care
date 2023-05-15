provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAUEQBJJJTRR3GMQ2S"
  secret_key = "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"
}

resource "aws_instance" "test-server" {
  ami           = "ami-0b08bfc6ff7069aff" 
  instance_type = "t2.micro"
  key_name = "gnan"
  vpc_security_group_ids= ["sg-09e2c8be5cc7b0db2"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("gnan.pem")
    host     = self.public_ip
  }
#provisioner "remote-exec" {
 #   inline = [ "echo 'wait to start instance' "]
  #}
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory.txt "
		}
  provisioner "local-exec" {
  command = "ansible-playbook playbook.yml"
}
}
