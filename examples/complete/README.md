# Complete Example

This example demonstrates the complete usage of the terraform-alicloud-ros module, showing how to create and manage ROS (Resource Orchestration Service) resources including stacks, templates, stack groups, and related components.

## Usage

To run this example, you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.100.0 |

## Features Demonstrated

This example shows how to:

1. **Create a ROS Stack** - The basic unit of ROS for managing a collection of resources
2. **Create a ROS Template** (optional) - Define reusable infrastructure templates
3. **Create a ROS Stack Group** (optional) - Manage stacks across multiple regions or accounts
4. **Create Stack Instances** (optional) - Deploy stack group templates to specific regions/accounts
5. **Create Change Sets** (currently disabled in this example) - Preview changes before applying them to stacks
6. **Create Template Scratch** (optional) - Import existing resources or replicate architectures

## Configuration Examples

### Basic Stack Creation

```hcl
module "ros" {
  source = "../../"

  create_stack = true
  stack_config = {
    stack_name         = "my-ros-stack"
    disable_rollback   = false
    timeout_in_minutes = 60
  }

  custom_template_body = jsonencode({
    "ROSTemplateFormatVersion" = "2015-09-01"
    "Description" = "Example template"
    "Resources" = {
      "MyVPC" = {
        "Type" = "ALIYUN::ECS::VPC"
        "Properties" = {
          "CidrBlock" = "10.0.0.0/16"
          "VpcName" = "example-vpc"
        }
      }
    }
  })
}
```

### Stack Group with Auto Deployment

```hcl
module "ros" {
  source = "../../"

  create_stack_group = true
  stack_group_config = {
    stack_group_name = "my-stack-group"
    permission_model = "SERVICE_MANAGED"
    auto_deployment = {
      enabled                           = true
      retain_stacks_on_account_removal = false
    }
  }
}
```

### Template Scratch for Resource Import

```hcl
module "ros" {
  source = "../../"

  create_template_scratch = true
  template_scratch_config = {
    template_scratch_type = "ResourceImport"
    execution_mode       = "Async"
    source_resource_group = {
      resource_group_id    = "rg-example"
      resource_type_filter = ["ALIYUN::ECS::VPC", "ALIYUN::ECS::VSwitch"]
    }
  }
}
```

## Important Notes

1. **Template Body**: If you don't provide a custom template body, the module will use a default empty template. For production use, always provide a meaningful template.

2. **Stack Groups**: Stack groups are useful for managing resources across multiple regions or accounts. They require appropriate IAM permissions.

3. **Change Sets**: Use change sets to preview changes before applying them to your stacks, especially in production environments. Note that in this example, change set creation is disabled due to a limitation where change sets share the same template as the associated stack, causing conflicts when trying to update a stack with identical template content.

4. **Template Scratch**: This feature is useful for importing existing resources into ROS management or for replicating existing architectures.

5. **Resource Dependencies**: Some resources depend on others (e.g., stack instances require stack groups). Make sure to enable parent resources when using dependent ones.

## Cleanup

To clean up the resources created by this example:

```bash
$ terraform destroy
```

**Warning**: This will destroy all resources created by this example. Make sure you want to delete them before running this command.