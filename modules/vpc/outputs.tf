output "public_subnet1_ids" {
  description = "List of public subnet IDs."
  value       = aws_subnet.public_pub_sub1[*].id
}

output "public_subnet2_ids" {
  description = "List of public subnet 2 IDs."
  value       = aws_subnet.public_pub_sub2[*].id
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.public_vpc.id
}

