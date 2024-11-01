resource "aws_instance" "bastion" {
  ami           = var.bastion_ami_id
  instance_type = var.bastion_instance_type
  key_name      = var.ec2_key_pair
  subnet_id     = element(var.public_subnet_ids, 0)
  vpc_security_group_ids = [var.bastion_sg_id]


  tags = {
    Name = "dev-partneraX-bastion-host"
  }
}