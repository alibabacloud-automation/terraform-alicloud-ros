
# Define resource IDs using locals for flexible resource management
locals {
  # Stack ID - use created stack if create_stack is true, otherwise use provided stack ID
  this_stack_id = var.create_stack ? alicloud_ros_stack.stack[0].id : var.stack_id

  # Template ID - use created template if create_template is true, otherwise use provided template ID
  this_template_id = var.create_template ? alicloud_ros_template.template[0].id : var.template_id

  # Stack Group ID - use created stack group if create_stack_group is true, otherwise use provided stack group ID
  this_stack_group_id = var.create_stack_group ? alicloud_ros_stack_group.stack_group[0].id : var.stack_group_id
}

# ROS Template resource (optional creation)
resource "alicloud_ros_template" "template" {
  count = var.create_template ? 1 : 0

  template_name = var.template_config.template_name
  description   = var.template_config.description
  template_body = var.template_config.template_body
  template_url  = var.template_config.template_url
  tags          = var.common_tags
}

# ROS Stack resource (optional creation)
resource "alicloud_ros_stack" "stack" {
  count = var.create_stack ? 1 : 0

  stack_name                      = var.stack_config.stack_name
  template_body                   = var.stack_config.template_body
  template_url                    = var.stack_config.template_url
  template_version                = var.stack_config.template_version
  disable_rollback                = var.stack_config.disable_rollback
  timeout_in_minutes              = var.stack_config.timeout_in_minutes
  stack_policy_body               = var.stack_config.stack_policy_body
  stack_policy_url                = var.stack_config.stack_policy_url
  stack_policy_during_update_body = var.stack_config.stack_policy_during_update_body
  stack_policy_during_update_url  = var.stack_config.stack_policy_during_update_url
  ram_role_name                   = var.stack_config.ram_role_name
  replacement_option              = var.stack_config.replacement_option
  create_option                   = var.stack_config.create_option
  deletion_protection             = var.stack_config.deletion_protection
  retain_all_resources            = var.stack_config.retain_all_resources
  use_previous_parameters         = var.stack_config.use_previous_parameters
  notification_urls               = var.stack_config.notification_urls
  retain_resources                = var.stack_config.retain_resources
  tags                            = var.common_tags

  dynamic "parameters" {
    for_each = var.stack_parameters
    content {
      parameter_key   = parameters.value.parameter_key
      parameter_value = parameters.value.parameter_value
    }
  }
}

# ROS Stack Group resource (optional creation)
resource "alicloud_ros_stack_group" "stack_group" {
  count = var.create_stack_group ? 1 : 0

  stack_group_name         = var.stack_group_config.stack_group_name
  description              = var.stack_group_config.description
  template_body            = var.stack_group_config.template_body
  template_url             = var.stack_group_config.template_url
  template_id              = var.stack_group_config.template_id
  template_version         = var.stack_group_config.template_version
  administration_role_name = var.stack_group_config.administration_role_name
  execution_role_name      = var.stack_group_config.execution_role_name
  permission_model         = var.stack_group_config.permission_model
  resource_group_id        = var.stack_group_config.resource_group_id
  capabilities             = var.stack_group_config.capabilities
  tags                     = var.common_tags

  dynamic "parameters" {
    for_each = var.stack_group_parameters
    content {
      parameter_key   = parameters.value.parameter_key
      parameter_value = parameters.value.parameter_value
    }
  }

  dynamic "auto_deployment" {
    for_each = var.stack_group_config.auto_deployment != null ? [var.stack_group_config.auto_deployment] : []
    content {
      enabled                          = auto_deployment.value.enabled
      retain_stacks_on_account_removal = auto_deployment.value.retain_stacks_on_account_removal
    }
  }
}

# ROS Stack Instance resource (depends on stack group)
resource "alicloud_ros_stack_instance" "stack_instance" {
  count = var.create_stack_instance ? 1 : 0

  stack_group_name          = local.this_stack_group_id
  stack_instance_account_id = var.stack_instance_config.stack_instance_account_id
  stack_instance_region_id  = var.stack_instance_config.stack_instance_region_id
  operation_description     = var.stack_instance_config.operation_description
  operation_preferences     = var.stack_instance_config.operation_preferences
  timeout_in_minutes        = var.stack_instance_config.timeout_in_minutes
  retain_stacks             = var.stack_instance_config.retain_stacks

  dynamic "parameter_overrides" {
    for_each = var.stack_instance_parameter_overrides
    content {
      parameter_key   = parameter_overrides.value.parameter_key
      parameter_value = parameter_overrides.value.parameter_value
    }
  }
}

# ROS Change Set resource (depends on stack)
resource "alicloud_ros_change_set" "change_set" {
  count = var.create_change_set ? 1 : 0

  change_set_name                 = var.change_set_config.change_set_name
  stack_name                      = var.change_set_config.stack_name
  stack_id                        = local.this_stack_id
  change_set_type                 = var.change_set_config.change_set_type
  description                     = var.change_set_config.description
  template_body                   = var.change_set_config.template_body
  template_url                    = var.change_set_config.template_url
  disable_rollback                = var.change_set_config.disable_rollback
  timeout_in_minutes              = var.change_set_config.timeout_in_minutes
  stack_policy_body               = var.change_set_config.stack_policy_body
  stack_policy_url                = var.change_set_config.stack_policy_url
  stack_policy_during_update_body = var.change_set_config.stack_policy_during_update_body
  stack_policy_during_update_url  = var.change_set_config.stack_policy_during_update_url
  ram_role_name                   = var.change_set_config.ram_role_name
  replacement_option              = var.change_set_config.replacement_option
  use_previous_parameters         = var.change_set_config.use_previous_parameters
  notification_urls               = var.change_set_config.notification_urls

  dynamic "parameters" {
    for_each = var.change_set_parameters
    content {
      parameter_key   = parameters.value.parameter_key
      parameter_value = parameters.value.parameter_value
    }
  }

  lifecycle {
    ignore_changes = [parameters]
  }
}

# ROS Template Scratch resource (optional creation)
resource "alicloud_ros_template_scratch" "template_scratch" {
  count = var.create_template_scratch ? 1 : 0

  template_scratch_type = var.template_scratch_config.template_scratch_type
  description           = var.template_scratch_config.description
  execution_mode        = var.template_scratch_config.execution_mode
  logical_id_strategy   = var.template_scratch_config.logical_id_strategy

  dynamic "preference_parameters" {
    for_each = var.template_scratch_preference_parameters
    content {
      parameter_key   = preference_parameters.value.parameter_key
      parameter_value = preference_parameters.value.parameter_value
    }
  }

  dynamic "source_resources" {
    for_each = var.template_scratch_source_resources
    content {
      resource_id   = source_resources.value.resource_id
      resource_type = source_resources.value.resource_type
    }
  }

  dynamic "source_resource_group" {
    for_each = var.template_scratch_config.source_resource_group != null ? [var.template_scratch_config.source_resource_group] : []
    content {
      resource_group_id    = source_resource_group.value.resource_group_id
      resource_type_filter = source_resource_group.value.resource_type_filter
    }
  }

  dynamic "source_tag" {
    for_each = var.template_scratch_config.source_tag != null ? [var.template_scratch_config.source_tag] : []
    content {
      resource_tags        = source_tag.value.resource_tags
      resource_type_filter = source_tag.value.resource_type_filter
    }
  }
}