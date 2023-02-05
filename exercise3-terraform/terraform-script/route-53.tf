resource "aws_route53_zone" "domain-name" {
    name = var.domain_name
    
    tags = {
      Name = "var.domain_name"
    }
}

resource "aws_route53_record" "record" {
    zone_id = aws_route53_zone.domain-name.zone_id
    name = "terraform-test.kingsax.me"
    type = "CNAME"
    ttl = 300
    records = ["${aws_lb.my-lb.dns_name}"]

#    alias {
#        name = aws_lb.my-lb.dns_name
#        zone_id = aws_lb.my-lb.zone_id
#        evaluate_target_health = true
#    }
#    depends_on = [
#        aws_lb.my-lb
#    ]
}
