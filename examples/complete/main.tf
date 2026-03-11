# Configure the Alicloud Provider
provider "alicloud" {
  region = var.region
}

# Data sources for getting available resources
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

# Generate random suffix for unique names
resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

data "alicloud_account" "this" {
}

# ============================================================================
# Complete ROS Module Example - All Resources
# ============================================================================

# Call the ROS module with all resources enabled
module "ros_complete" {
  source = "../../"

  # ============================================================================
  # 1. ROS Template
  # ============================================================================
  create_template = true
  template_config = {
    template_name = "example-ros-template-${random_integer.suffix.result}"
    description   = "Complete example ROS template"
    template_body = jsonencode({
      ROSTemplateFormatVersion = "2015-09-01"
      Description              = "Complete ROS template with VPC parameter"
      Parameters = {
        VpcName = {
          Type        = "String"
          Description = "Name of the VPC"
          Default     = "ExampleVPC"
        }
        InstanceType = {
          Type        = "String"
          Description = "Instance type for ECS"
          Default     = "ecs.g6.large"
        }
      }
      Resources = {
        # Empty resources for this example
      }
      Outputs = {
        VpcNameOutput = {
          Description = "The VPC name"
          Value = {
            Ref = "VpcName"
          }
        }
      }
    })
  }

  # ============================================================================
  # 2. ROS Stack
  # ============================================================================
  create_stack = true # 恢复为 true，先创建一个基础堆栈
  stack_config = {
    stack_name          = "example-ros-stack-${random_integer.suffix.result}"
    disable_rollback    = false
    timeout_in_minutes  = 60
    deletion_protection = "Disabled"
    template_body = jsonencode({
      ROSTemplateFormatVersion = "2015-09-01"
      Description              = "Complete ROS template with VPC parameter"
      Parameters = {
        VpcName = {
          Type        = "String"
          Description = "Name of the VPC"
          Default     = "ExampleVPC"
        }
        InstanceType = {
          Type        = "String"
          Description = "Instance type for ECS"
          Default     = "ecs.g6.large"
        }
      }
      Resources = {
        # Empty resources for this example
      }
      Outputs = {
        VpcNameOutput = {
          Description = "The VPC name"
          Value = {
            Ref = "VpcName"
          }
        }
      }
    })
    stack_policy_body = jsonencode({
      Statement = [{
        Action    = "Update:*"
        Resource  = "*"
        Effect    = "Allow"
        Principal = "*"
      }]
    })
  }

  stack_parameters = [
    {
      parameter_key   = "VpcName"
      parameter_value = "ExampleVPC"
    },
    {
      parameter_key   = "InstanceType"
      parameter_value = "ecs.g6.large"
    }
  ]

  # ============================================================================
  # 3. ROS Stack Group
  # ============================================================================
  create_stack_group = true
  stack_group_config = {
    stack_group_name = "example-stack-group-${random_integer.suffix.result}"
    description      = "Complete example ROS stack group"
    permission_model = "SELF_MANAGED"
    template_body = jsonencode({
      ROSTemplateFormatVersion = "2015-09-01"
      Description              = "Complete ROS template with VPC parameter"
      Parameters = {
        VpcName = {
          Type        = "String"
          Description = "Name of the VPC"
          Default     = "ExampleVPC"
        }
        InstanceType = {
          Type        = "String"
          Description = "Instance type for ECS"
          Default     = "ecs.g6.large"
        }
      }
      Resources = {
        # Empty resources for this example
      }
      Outputs = {
        VpcNameOutput = {
          Description = "The VPC name"
          Value = {
            Ref = "VpcName"
          }
        }
      }
    })
  }

  stack_group_parameters = [
    {
      parameter_key   = "VpcName"
      parameter_value = "StackGroupVPC"
    },
    {
      parameter_key   = "InstanceType"
      parameter_value = "ecs.g6.large"
    }
  ]

  # ============================================================================
  # 4. ROS Stack Instance
  # ============================================================================
  create_stack_instance = true # 启用堆栈实例创建
  stack_instance_config = {
    stack_instance_account_id = data.alicloud_account.this.id
    stack_instance_region_id  = var.region # 使用与 provider 相同的区域
    operation_description     = "Complete example stack instance"
    operation_preferences = jsonencode({
      FailureToleranceCount = 1
      MaxConcurrentCount    = 2
    })
    timeout_in_minutes = "60"
    retain_stacks      = "false"
  }

  stack_instance_parameter_overrides = [
    {
      parameter_key   = "VpcName"
      parameter_value = "InstanceVPC"
    }
  ]

  # ============================================================================
  # 5. ROS Change Set (Commented out due to limitations with template reuse)
  # ============================================================================
  # create_change_set = true  # Temporarily disabled due to template conflict
  # change_set_config = {
  #   change_set_name = "example-change-set-${random_integer.suffix.result}"
  #   stack_name      = "example-ros-stack-${random_integer.suffix.result}"  # 指向我们创建的堆栈
  #   change_set_type = "UPDATE"
  #   description     = "Complete example change set for updating existing stack"
  # }
  #
  # change_set_parameters = [
  #   {
  #     parameter_key   = "VpcName"
  #     parameter_value = "UpdatedVPC"
  #   },
  #   {
  #     parameter_key   = "InstanceType"
  #     parameter_value = "ecs.t5-lc1m1.small"
  #   }
  # ]

  create_change_set = false # 禁用变更集以避免冲突

  # ============================================================================
  # 6. ROS Template Scratch
  # ============================================================================
  create_template_scratch = true
  template_scratch_config = {
    template_scratch_type = "ResourceImport"
    description           = "Complete example template scratch for resource import"
    execution_mode        = "Async"
    logical_id_strategy   = "LongTypePrefixAndIndexSuffix"
    source_resource_group = {
      resource_group_id    = data.alicloud_resource_manager_resource_groups.default.ids[0]
      resource_type_filter = ["ALIYUN::ECS::VPC"]
    }
  }

  template_scratch_preference_parameters = [
    {
      parameter_key   = "DeletionPolicy"
      parameter_value = "Retain"
    }
  ]

  # Common tags for all resources
  common_tags = {
    Environment = "example"
    Project     = "ros-module-complete-test"
    ManagedBy   = "Terraform"
  }
}
