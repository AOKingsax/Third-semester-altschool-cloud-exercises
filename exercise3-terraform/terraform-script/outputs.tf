output "aws_instance_public_dns1" {
    value = aws_instance.webserver.public_ip
}

output "aws_instance_public_dns2" {
    value = aws_instance.webserver1.public_ip
}

output "aws_instance_public_dns3" {
    value = aws_instance.webserver2.public_ip
}

output "aws_load_balancer_public_dns" {
    value = aws_lb.my-lb.dns_name
}

resource "local_file" "ip_address" {
    filename = "/home/kingsax/terraform/ansible-script/host-inventory.txt"
    content = <<EOT
    ${aws_instance.webserver.public_ip}
    ${aws_instance.webserver1.public_ip}
    ${aws_instance.webserver2.public_ip}
    EOT
}
