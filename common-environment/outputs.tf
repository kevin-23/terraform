output "alb_dns" {
  value       = module.ec2.alb_dns
  description = "Shows the ALB DNS"
}
