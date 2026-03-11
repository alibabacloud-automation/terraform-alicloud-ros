阿里云 ROS (资源编排服务) Terraform 模块

# terraform-alicloud-ros

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ros/blob/main/README.md) | 简体中文

用于在阿里云上创建和管理 ROS (资源编排服务) 资源的 Terraform 模块。该模块通过管理 ROS 堆栈、模板、堆栈组和相关组件，为[基础设施编排和自动化](https://www.alibabacloud.com/product/ros)提供综合解决方案。ROS 使您能够在模板中定义云资源，并以可预测和可重复的方式进行配置。

## 使用方法

该模块允许您使用灵活的配置选项创建和管理 ROS 资源。您可以创建单独的堆栈、管理模板、为多区域部署设置堆栈组，以及处理变更集以进行安全更新。

```terraform
module "ros" {
  source = "alibabacloud-automation/ros/alicloud"

  # 使用自定义模板创建 ROS 堆栈
  create_stack = true
  stack_config = {
    stack_name         = "my-infrastructure-stack"
    disable_rollback   = false
    timeout_in_minutes = 60
    deletion_protection = "Disabled"
  }

  # 提供自定义 ROS 模板
  custom_template_body = jsonencode({
    "ROSTemplateFormatVersion" = "2015-09-01"
    "Description" = "示例基础设施模板"
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

  # 堆栈参数
  stack_parameters = [
    {
      parameter_key   = "Environment"
      parameter_value = "production"
    }
  ]

  # 通用标签
  common_tags = {
    Environment = "production"
    Project     = "infrastructure"
    ManagedBy   = "terraform"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ros/tree/main/examples/complete) - 展示了所有 ROS 功能的综合使用，包括堆栈、模板、堆栈组和变更集

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)