resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = file (var.public_key_path)

}

resource "aws_instance" "ec2" {

  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  subnet_id = var.subnet_id
  tags = {

    name = var.instance_name

  }
}