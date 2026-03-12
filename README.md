Terraform module for Alibaba Cloud ROS (Resource Orchestration Service) resources

# terraform-alicloud-ros

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-ros/blob/main/README-CN.md)

Terraform module which creates and manages ROS (Resource Orchestration Service) resources on Alibaba Cloud. This module provides a comprehensive solution for [infrastructure orchestration and automation](https://www.alibabacloud.com/product/ros) by managing ROS stacks, templates, stack groups, and related components. ROS enables you to define cloud resources in templates and provision them in a predictable and repeatable way.

## Usage

This module allows you to create and manage ROS resources with flexible configuration options. You can create individual stacks, manage templates, set up stack groups for multi-region deployments, and handle change sets for safe updates.

```terraform
module "ros" {
  source = "alibabacloud-automation/ros/alicloud"

  # Create a ROS stack with custom template
  create_stack = true
  stack_config = {
    stack_name          = "my-infrastructure-stack"
    disable_rollback    = false
    timeout_in_minutes  = 60
    deletion_protection = "Disabled"
    template_body = jsonencode({
      "ROSTemplateFormatVersion" = "2015-09-01"
      "Description" = "Example infrastructure template"
      "Resources" = {
        "MyVPC" = {
          "Type" = "ALIYUN::ECS::VPC"
          "Properties" = {
            "CidrBlock" = "10.0.0.0/16"
            "VpcName"   = "example-vpc"
          }
        }
      }
    })
  }

  # Common tags
  common_tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ros/tree/main/examples/complete) - Shows comprehensive usage of all ROS features including stacks, templates, stack groups, and change sets

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.100.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ros_change_set.change_set](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_change_set) | resource |
| [alicloud_ros_stack.stack](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_stack) | resource |
| [alicloud_ros_stack_group.stack_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_stack_group) | resource |
| [alicloud_ros_stack_instance.stack_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_stack_instance) | resource |
| [alicloud_ros_template.template](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_template) | resource |
| [alicloud_ros_template_scratch.template_scratch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_template_scratch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_change_set_config"></a> [change\_set\_config](#input\_change\_set\_config) | Configuration for the ROS change set. The attributes 'change\_set\_name', 'stack\_name', 'change\_set\_type', and 'template\_body' are required when create\_change\_set is true. | <pre>object({<br/>    change_set_name                 = string<br/>    stack_name                      = string<br/>    change_set_type                 = string<br/>    description                     = optional(string, "ROS change set created by Terraform")<br/>    template_body                   = optional(string, null)<br/>    template_url                    = optional(string, null)<br/>    disable_rollback                = optional(bool, null)<br/>    timeout_in_minutes              = optional(number, null)<br/>    stack_policy_body               = optional(string, null)<br/>    stack_policy_url                = optional(string, null)<br/>    stack_policy_during_update_body = optional(string, null)<br/>    stack_policy_during_update_url  = optional(string, null)<br/>    ram_role_name                   = optional(string, null)<br/>    replacement_option              = optional(string, null)<br/>    use_previous_parameters         = optional(bool, null)<br/>    notification_urls               = optional(list(string), null)<br/>  })</pre> | <pre>{<br/>  "change_set_name": null,<br/>  "change_set_type": null,<br/>  "stack_name": null,<br/>  "template_body": null<br/>}</pre> | no |
| <a name="input_change_set_parameters"></a> [change\_set\_parameters](#input\_change\_set\_parameters) | List of parameters for the ROS change set. | <pre>list(object({<br/>    parameter_key   = string<br/>    parameter_value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of common tags to assign to all resources. | `map(string)` | `{}` | no |
| <a name="input_create_change_set"></a> [create\_change\_set](#input\_create\_change\_set) | Whether to create a ROS change set for the stack. | `bool` | `false` | no |
| <a name="input_create_stack"></a> [create\_stack](#input\_create\_stack) | Whether to create a new ROS stack. If false, an existing stack ID must be provided. | `bool` | `true` | no |
| <a name="input_create_stack_group"></a> [create\_stack\_group](#input\_create\_stack\_group) | Whether to create a new ROS stack group. If false, an existing stack group ID must be provided. | `bool` | `false` | no |
| <a name="input_create_stack_instance"></a> [create\_stack\_instance](#input\_create\_stack\_instance) | Whether to create a ROS stack instance in the stack group. | `bool` | `false` | no |
| <a name="input_create_template"></a> [create\_template](#input\_create\_template) | Whether to create a new ROS template. If false, an existing template ID must be provided. | `bool` | `false` | no |
| <a name="input_create_template_scratch"></a> [create\_template\_scratch](#input\_create\_template\_scratch) | Whether to create a ROS template scratch for resource import or architecture replication. | `bool` | `false` | no |
| <a name="input_stack_config"></a> [stack\_config](#input\_stack\_config) | Configuration for the ROS stack. The attributes 'stack\_name' and 'template\_body' are required when create\_stack is true. | <pre>object({<br/>    stack_name                      = string<br/>    template_body                   = optional(string, null)<br/>    template_url                    = optional(string, null)<br/>    template_version                = optional(string, null)<br/>    disable_rollback                = optional(bool, false)<br/>    timeout_in_minutes              = optional(number, 60)<br/>    stack_policy_body               = optional(string, null)<br/>    stack_policy_url                = optional(string, null)<br/>    stack_policy_during_update_body = optional(string, null)<br/>    stack_policy_during_update_url  = optional(string, null)<br/>    ram_role_name                   = optional(string, null)<br/>    replacement_option              = optional(string, null)<br/>    create_option                   = optional(string, null)<br/>    deletion_protection             = optional(string, "Disabled")<br/>    retain_all_resources            = optional(bool, null)<br/>    use_previous_parameters         = optional(bool, null)<br/>    notification_urls               = optional(list(string), null)<br/>    retain_resources                = optional(list(string), null)<br/>  })</pre> | <pre>{<br/>  "stack_name": null,<br/>  "template_body": null<br/>}</pre> | no |
| <a name="input_stack_group_config"></a> [stack\_group\_config](#input\_stack\_group\_config) | Configuration for the ROS stack group. The attributes 'stack\_group\_name' and 'template\_body' are required when create\_stack\_group is true. | <pre>object({<br/>    stack_group_name         = string<br/>    description              = optional(string, "ROS stack group created by Terraform")<br/>    template_body            = optional(string, null)<br/>    template_url             = optional(string, null)<br/>    template_id              = optional(string, null)<br/>    template_version         = optional(string, null)<br/>    administration_role_name = optional(string, null)<br/>    execution_role_name      = optional(string, null)<br/>    permission_model         = optional(string, null)<br/>    resource_group_id        = optional(string, null)<br/>    capabilities             = optional(list(string), null)<br/>    auto_deployment = optional(object({<br/>      enabled                          = bool<br/>      retain_stacks_on_account_removal = bool<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "stack_group_name": null,<br/>  "template_body": null<br/>}</pre> | no |
| <a name="input_stack_group_id"></a> [stack\_group\_id](#input\_stack\_group\_id) | The ID of an existing ROS stack group. Required when create\_stack\_group is false. | `string` | `null` | no |
| <a name="input_stack_group_parameters"></a> [stack\_group\_parameters](#input\_stack\_group\_parameters) | List of parameters for the ROS stack group. | <pre>list(object({<br/>    parameter_key   = string<br/>    parameter_value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_stack_id"></a> [stack\_id](#input\_stack\_id) | The ID of an existing ROS stack. Required when create\_stack is false. | `string` | `null` | no |
| <a name="input_stack_instance_config"></a> [stack\_instance\_config](#input\_stack\_instance\_config) | Configuration for the ROS stack instance. | <pre>object({<br/>    stack_instance_account_id = optional(string, null)<br/>    stack_instance_region_id  = optional(string, null)<br/>    operation_description     = optional(string, "Stack instance operation via Terraform")<br/>    operation_preferences     = optional(string, null)<br/>    timeout_in_minutes        = optional(string, "60")<br/>    retain_stacks             = optional(string, "false")<br/>  })</pre> | `{}` | no |
| <a name="input_stack_instance_parameter_overrides"></a> [stack\_instance\_parameter\_overrides](#input\_stack\_instance\_parameter\_overrides) | List of parameter overrides for the ROS stack instance. | <pre>list(object({<br/>    parameter_key   = string<br/>    parameter_value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_stack_parameters"></a> [stack\_parameters](#input\_stack\_parameters) | List of parameters for the ROS stack. | <pre>list(object({<br/>    parameter_key   = string<br/>    parameter_value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_template_config"></a> [template\_config](#input\_template\_config) | Configuration for the ROS template. The attributes 'template\_name' and 'template\_body' are required when create\_template is true. | <pre>object({<br/>    template_name = string<br/>    description   = optional(string, "ROS template created by Terraform")<br/>    template_body = optional(string, null)<br/>    template_url  = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "template_body": null,<br/>  "template_name": null<br/>}</pre> | no |
| <a name="input_template_id"></a> [template\_id](#input\_template\_id) | The ID of an existing ROS template. Required when create\_template is false. | `string` | `null` | no |
| <a name="input_template_scratch_config"></a> [template\_scratch\_config](#input\_template\_scratch\_config) | Configuration for the ROS template scratch. The attribute 'template\_scratch\_type' is required when create\_template\_scratch is true. | <pre>object({<br/>    template_scratch_type = string<br/>    description           = optional(string, "ROS template scratch created by Terraform")<br/>    execution_mode        = optional(string, null)<br/>    logical_id_strategy   = optional(string, null)<br/>    source_resource_group = optional(object({<br/>      resource_group_id    = string<br/>      resource_type_filter = optional(list(string), null)<br/>    }), null)<br/>    source_tag = optional(object({<br/>      resource_tags        = map(string)<br/>      resource_type_filter = optional(list(string), null)<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "template_scratch_type": null<br/>}</pre> | no |
| <a name="input_template_scratch_preference_parameters"></a> [template\_scratch\_preference\_parameters](#input\_template\_scratch\_preference\_parameters) | List of preference parameters for the ROS template scratch. | <pre>list(object({<br/>    parameter_key   = string<br/>    parameter_value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_template_scratch_source_resources"></a> [template\_scratch\_source\_resources](#input\_template\_scratch\_source\_resources) | List of source resources for the ROS template scratch. | <pre>list(object({<br/>    resource_id   = string<br/>    resource_type = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_change_set_id"></a> [change\_set\_id](#output\_change\_set\_id) | The ID of the ROS change set |
| <a name="output_change_set_name"></a> [change\_set\_name](#output\_change\_set\_name) | The name of the ROS change set |
| <a name="output_change_set_status"></a> [change\_set\_status](#output\_change\_set\_status) | The status of the ROS change set |
| <a name="output_stack_group_id"></a> [stack\_group\_id](#output\_stack\_group\_id) | The ID of the ROS stack group |
| <a name="output_stack_group_name"></a> [stack\_group\_name](#output\_stack\_group\_name) | The name of the ROS stack group |
| <a name="output_stack_group_status"></a> [stack\_group\_status](#output\_stack\_group\_status) | The status of the ROS stack group |
| <a name="output_stack_id"></a> [stack\_id](#output\_stack\_id) | The ID of the ROS stack |
| <a name="output_stack_instance_account_id"></a> [stack\_instance\_account\_id](#output\_stack\_instance\_account\_id) | The account ID of the ROS stack instance |
| <a name="output_stack_instance_id"></a> [stack\_instance\_id](#output\_stack\_instance\_id) | The ID of the ROS stack instance |
| <a name="output_stack_instance_region_id"></a> [stack\_instance\_region\_id](#output\_stack\_instance\_region\_id) | The region ID of the ROS stack instance |
| <a name="output_stack_instance_status"></a> [stack\_instance\_status](#output\_stack\_instance\_status) | The status of the ROS stack instance |
| <a name="output_stack_name"></a> [stack\_name](#output\_stack\_name) | The name of the ROS stack |
| <a name="output_stack_status"></a> [stack\_status](#output\_stack\_status) | The status of the ROS stack |
| <a name="output_template_id"></a> [template\_id](#output\_template\_id) | The ID of the ROS template |
| <a name="output_template_name"></a> [template\_name](#output\_template\_name) | The name of the ROS template |
| <a name="output_template_scratch_id"></a> [template\_scratch\_id](#output\_template\_scratch\_id) | The ID of the ROS template scratch |
| <a name="output_template_scratch_status"></a> [template\_scratch\_status](#output\_template\_scratch\_status) | The status of the ROS template scratch |
| <a name="output_this_stack_group_id"></a> [this\_stack\_group\_id](#output\_this\_stack\_group\_id) | The ID of the stack group (created or provided) |
| <a name="output_this_stack_id"></a> [this\_stack\_id](#output\_this\_stack\_id) | The ID of the stack (created or provided) |
| <a name="output_this_template_id"></a> [this\_template\_id](#output\_this\_template\_id) | The ID of the template (created or provided) |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)