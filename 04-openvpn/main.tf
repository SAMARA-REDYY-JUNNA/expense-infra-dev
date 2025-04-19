# resource "aws_key_pair" "vpn" {
#   key_name = "openvpn"
#   #you can paste the public key here directly
#   #public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBokHFJVgvLItExM8gYrOjeEFwy1ERWCF5e8sICTZLo Samara reddy@samara-reddy-junna"
#   public_key = file("~/.ssh/openvpn.pub")
#   #~means windows home
# }
# module "vpn" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   key_name = aws_key_pair.vpn.key_name
#   name = "${var.project_name}-${var.environment}-vpn"

#   instance_type          = "t3.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
#   subnet_id              = local.public_subnet_id
#   ami                    =  data.aws_ami.ami_info.id 

#   tags = merge (
#     var.common_tags,
#     {
#       Name = "${var.project_name}-${var.environment}-vpn"
#     }
# )
# }

resource "aws_instance" "openvpn" {
  ami = data.aws_ami.ami_info.id
  key_name = data.aws_key_pair.vpn.key_name
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id = local.public_subnet_id
  user_data = file("user-data.sh")
  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}