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
    stack_name         = "my-infrastructure-stack"
    disable_rollback   = false
    timeout_in_minutes = 60
    deletion_protection = "Disabled"
  }

  # Provide custom ROS template
  custom_template_body = jsonencode({
    "ROSTemplateFormatVersion" = "2015-09-01"
    "Description" = "Example infrastructure template"
    "Resources" = {
      "MyVPC" = {
        "Type" = "ALIYUN::ECS::VPC"
        "Properties" = {
          "CidrBlock" = "10.0.0.0/16"
          "VpcName" = "example-vpc"
        }
      }
      "MyVSwitch" = {
        "Type" = "ALIYUN::ECS::VSwitch"
        "Properties" = {
          "VpcId" = { "Ref" = "MyVPC" }
          "CidrBlock" = "10.0.1.0/24"
          "VSwitchName" = "example-vswitch"
        }
      }
    }
  })

  # Stack parameters
  stack_parameters = [
    {
      parameter_key   = "Environment"
      parameter_value = "production"
    }
  ]

  # Common tags
  common_tags = {
    Environment = "production"
    Project     = "infrastructure"
    ManagedBy   = "terraform"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ros/tree/main/examples/complete) - Shows comprehensive usage of all ROS features including stacks, templates, stack groups, and change sets

<!-- BEGIN_TF_DOCS -->
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