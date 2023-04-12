output "id" {
  description = "The resource ID in UUID format"
  value       = huaweicloud_networking_secgroup.main.id
}

output "rules" {
  description = "The array of security group rules associating with the security group"
  value       = huaweicloud_networking_secgroup.main.rules
}
