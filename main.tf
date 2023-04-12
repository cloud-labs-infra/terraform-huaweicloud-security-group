locals {
  name = var.name_postfix == null ? format("%s-secgroup", var.name) : format("%s-secgroup-%s", var.name, var.name_postfix)
}

resource "huaweicloud_networking_secgroup" "main" {
  name                 = local.name
  description          = var.description
  delete_default_rules = var.allow_self_connection ? true : var.delete_default_rules
  region               = var.region
}

resource "huaweicloud_networking_secgroup_rule" "rules" {
  for_each = var.rules

  region            = var.region
  security_group_id = huaweicloud_networking_secgroup.main.id
  description       = each.key
  direction         = each.value.direction
  ethertype         = each.value.ethertype
  protocol          = each.value.protocol
  ports             = each.value.ports
  action            = each.value.action
  priority          = each.value.priority

  ##
  # The "remote_*" arguments have a priority:
  #   1. remote_ip_prefix
  #   2. remote_group_id
  #   3. remote_address_group_id
  #
  # If more than one passes - only one will apply in according to the priority above.
  ##
  remote_ip_prefix        = each.value.remote_ip_prefix
  remote_group_id         = each.value.remote_ip_prefix != null ? null : each.value.remote_group_id
  remote_address_group_id = each.value.remote_ip_prefix != null || each.value.remote_group_id != null ? null : each.value.remote_address_group_id
}

resource "huaweicloud_networking_secgroup_rule" "allow_self_inbound" {
  for_each          = var.allow_self_connection ? toset(["IPv4", "IPv6"]) : []
  region            = var.region
  security_group_id = huaweicloud_networking_secgroup.main.id
  description       = format("Allow Self Inbound for %s", each.value)
  direction         = "ingress"
  action            = "allow"
  priority          = 98
  ethertype         = each.value
  remote_group_id   = huaweicloud_networking_secgroup.main.id
}

resource "huaweicloud_networking_secgroup_rule" "allow_self_outbound" {
  for_each          = var.allow_self_connection ? toset(["IPv4", "IPv6"]) : []
  region            = var.region
  security_group_id = huaweicloud_networking_secgroup.main.id
  description       = format("Allow Self Outbound, %s", each.value)
  direction         = "egress"
  action            = "allow"
  priority          = 98
  ethertype         = each.value
  remote_group_id   = huaweicloud_networking_secgroup.main.id
}

resource "huaweicloud_networking_secgroup_rule" "default_deny_outbound" {
  for_each          = var.default_deny_outbound ? toset(["IPv4", "IPv6"]) : []
  region            = var.region
  security_group_id = huaweicloud_networking_secgroup.main.id
  description       = format("Deny Outbound to All, %s", each.value)
  direction         = "egress"
  action            = "deny"
  priority          = 100
  ethertype         = each.value
  remote_ip_prefix  = each.value == "IPv4" ? "0.0.0.0/0" : "::/0"
}

resource "huaweicloud_networking_secgroup_rule" "default_deny_inbound" {
  for_each          = var.default_deny_inbound ? toset(["IPv4", "IPv6"]) : []
  region            = var.region
  security_group_id = huaweicloud_networking_secgroup.main.id
  description       = format("Deny Inbound to All, %s", each.value)
  direction         = "ingress"
  action            = "deny"
  priority          = 100
  ethertype         = each.value
  remote_ip_prefix  = each.value == "IPv4" ? "0.0.0.0/0" : "::/0"
}
