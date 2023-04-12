variable "name" {
  description = "Specifies the name of the Networking Security Group"
  type        = string
  nullable    = false
}

variable "name_postfix" {
  description = "Name Postfix for Networking Security Group"
  type        = string
  default     = null
}

variable "description" {
  description = "Specifies the description for the security group"
  type        = string
  default     = null
}

variable "region" {
  description = "Specifies the region in which to create the resource, if omitted, the provider-level region will be used"
  type        = string
  default     = null
}

variable "delete_default_rules" {
  description = "Specifies whether or not to delete the default security rules"
  type        = bool
  default     = true
}

variable "allow_self_connection" {
  description = "Add self connection rule"
  type        = bool
  default     = true
}

variable "default_deny_outbound" {
  description = "Add Rule to deny egress to 0.0.0.0/0 by default with lowest priority"
  type        = bool
  default     = false
}

variable "default_deny_inbound" {
  description = "Add Rule to deny ingress from 0.0.0.0/0 by default with lowest priority"
  type        = bool
  default     = true
}

variable "rules" {
  description = <<DES
  Networking Security Group rules:

   * 'direction' specifies the direction of the rule, valid values are ingress or egress;
   * 'ethertype' specifies the layer 3 protocol type, valid values are IPv4 or IPv6;
   * 'protocol' valid values are tcp, udp, icmp and icmpv6;
   * 'ports' specifies the allowed port value range, which supports single port (80), continuous port (1-30) and discontinous port (22, 3389, 80);
   * 'action' specifies the effective policy, the valid values are allow and deny;
   * 'priority' Specifies the priority number, the valid value is range from 1 to 100.

   * 'remote_ip_prefix' specifies the remote CIDR;
   OR
   * 'remote_group_id' specifies the remote address Security Group ID;
   OR
   * 'remote_address_group_id' specifies the remote Address Group ID;
  DES
  type = map(object({
    direction               = string
    ethertype               = optional(string, "IPv4")
    protocol                = optional(string, null)
    ports                   = optional(string, null)
    action                  = optional(string, "allow")
    priority                = optional(number, null)
    remote_ip_prefix        = optional(string, null)
    remote_group_id         = optional(string, null)
    remote_address_group_id = optional(string, null)
  }))
}
