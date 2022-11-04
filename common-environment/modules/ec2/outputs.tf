output "alb_dns" {
  description = "URL of application load balancer"
  value       = "http://${aws_lb.alb.dns_name}"
}
