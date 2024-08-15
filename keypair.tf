#Creating ssh-key
resource "aws_key_pair" "key-tf" {
  key_name   = "test_drive"
  public_key = file("${path.module}/id_rsa.pub")
}
