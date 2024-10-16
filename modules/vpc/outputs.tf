output "public_pub_subnet1_ids" {
  value = aws_subnet.public_pub_sub1[*].id  # Keep this if there are multiple subnets
}

output "public_pub_subnet2_ids" {
  value = aws_subnet.public_pub_sub2[*].id  # Keep this if there are multiple subnets
}

output "vpc_id" {
  value = aws_vpc.public_vpc.id
}
