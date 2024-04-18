# Huawei Cloud Security Group
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_huaweicloud"></a> [huaweicloud](#requirement\_huaweicloud) | ~> 1.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_huaweicloud"></a> [huaweicloud](#provider\_huaweicloud) | ~> 1.63 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [huaweicloud_networking_secgroup.main](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/networking_secgroup) | resource |
| [huaweicloud_networking_secgroup_rule.allow_self_inbound](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/networking_secgroup_rule) | resource |
| [huaweicloud_networking_secgroup_rule.allow_self_outbound](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/networking_secgroup_rule) | resource |
| [huaweicloud_networking_secgroup_rule.default_deny_inbound](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/networking_secgroup_rule) | resource |
| [huaweicloud_networking_secgroup_rule.default_deny_outbound](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/networking_secgroup_rule) | resource |
| [huaweicloud_networking_secgroup_rule.rules](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/networking_secgroup_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_self_connection"></a> [allow\_self\_connection](#input\_allow\_self\_connection) | Add self connection rule | `bool` | `true` | no |
| <a name="input_default_deny_inbound"></a> [default\_deny\_inbound](#input\_default\_deny\_inbound) | Add Rule to deny ingress from 0.0.0.0/0 by default with lowest priority | `bool` | `true` | no |
| <a name="input_default_deny_outbound"></a> [default\_deny\_outbound](#input\_default\_deny\_outbound) | Add Rule to deny egress to 0.0.0.0/0 by default with lowest priority | `bool` | `false` | no |
| <a name="input_delete_default_rules"></a> [delete\_default\_rules](#input\_delete\_default\_rules) | Specifies whether or not to delete the default security rules | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Specifies the description for the security group | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Networking Security Group | `string` | n/a | yes |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | Name Postfix for Networking Security Group | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Specifies the region in which to create the resource, if omitted, the provider-level region will be used | `string` | `null` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Networking Security Group rules:<br><br>   * 'direction' specifies the direction of the rule, valid values are ingress or egress;<br>   * 'ethertype' specifies the layer 3 protocol type, valid values are IPv4 or IPv6;<br>   * 'protocol' valid values are tcp, udp, icmp and icmpv6;<br>   * 'ports' specifies the allowed port value range, which supports single port (80), continuous port (1-30) and discontinous port (22, 3389, 80);<br>   * 'action' specifies the effective policy, the valid values are allow and deny;<br>   * 'priority' Specifies the priority number, the valid value is range from 1 to 100.<br><br>   * 'remote\_ip\_prefix' specifies the remote CIDR;<br>   OR<br>   * 'remote\_group\_id' specifies the remote address Security Group ID;<br>   OR<br>   * 'remote\_address\_group\_id' specifies the remote Address Group ID; | <pre>map(object({<br>    direction               = string<br>    ethertype               = optional(string, "IPv4")<br>    protocol                = optional(string, null)<br>    ports                   = optional(string, null)<br>    action                  = optional(string, "allow")<br>    priority                = optional(number, null)<br>    remote_ip_prefix        = optional(string, null)<br>    remote_group_id         = optional(string, null)<br>    remote_address_group_id = optional(string, null)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The resource ID in UUID format |
| <a name="output_rules"></a> [rules](#output\_rules) | The array of security group rules associating with the security group |
<!-- END_TF_DOCS -->