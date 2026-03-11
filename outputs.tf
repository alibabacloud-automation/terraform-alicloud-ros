# =============================================================================
# Template Outputs
# =============================================================================

output "template_id" {
  description = "The ID of the ROS template"
  value       = var.create_template ? alicloud_ros_template.template[0].id : null
}

output "template_name" {
  description = "The name of the ROS template"
  value       = var.create_template ? alicloud_ros_template.template[0].template_name : null
}

# =============================================================================
# Stack Outputs
# =============================================================================

output "stack_id" {
  description = "The ID of the ROS stack"
  value       = var.create_stack ? alicloud_ros_stack.stack[0].id : null
}

output "stack_name" {
  description = "The name of the ROS stack"
  value       = var.create_stack ? alicloud_ros_stack.stack[0].stack_name : null
}

output "stack_status" {
  description = "The status of the ROS stack"
  value       = var.create_stack ? alicloud_ros_stack.stack[0].status : null
}

# =============================================================================
# Stack Group Outputs
# =============================================================================

output "stack_group_id" {
  description = "The ID of the ROS stack group"
  value       = var.create_stack_group ? alicloud_ros_stack_group.stack_group[0].stack_group_id : null
}

output "stack_group_name" {
  description = "The name of the ROS stack group"
  value       = var.create_stack_group ? alicloud_ros_stack_group.stack_group[0].stack_group_name : null
}

output "stack_group_status" {
  description = "The status of the ROS stack group"
  value       = var.create_stack_group ? alicloud_ros_stack_group.stack_group[0].status : null
}

# =============================================================================
# Stack Instance Outputs
# =============================================================================

output "stack_instance_id" {
  description = "The ID of the ROS stack instance"
  value       = var.create_stack_instance ? alicloud_ros_stack_instance.stack_instance[0].id : null
}

output "stack_instance_status" {
  description = "The status of the ROS stack instance"
  value       = var.create_stack_instance ? alicloud_ros_stack_instance.stack_instance[0].status : null
}

output "stack_instance_account_id" {
  description = "The account ID of the ROS stack instance"
  value       = var.create_stack_instance ? alicloud_ros_stack_instance.stack_instance[0].stack_instance_account_id : null
}

output "stack_instance_region_id" {
  description = "The region ID of the ROS stack instance"
  value       = var.create_stack_instance ? alicloud_ros_stack_instance.stack_instance[0].stack_instance_region_id : null
}

# =============================================================================
# Change Set Outputs
# =============================================================================

output "change_set_id" {
  description = "The ID of the ROS change set"
  value       = var.create_change_set ? alicloud_ros_change_set.change_set[0].id : null
}

output "change_set_name" {
  description = "The name of the ROS change set"
  value       = var.create_change_set ? alicloud_ros_change_set.change_set[0].change_set_name : null
}

output "change_set_status" {
  description = "The status of the ROS change set"
  value       = var.create_change_set ? alicloud_ros_change_set.change_set[0].status : null
}

# =============================================================================
# Template Scratch Outputs
# =============================================================================

output "template_scratch_id" {
  description = "The ID of the ROS template scratch"
  value       = var.create_template_scratch ? alicloud_ros_template_scratch.template_scratch[0].id : null
}

output "template_scratch_status" {
  description = "The status of the ROS template scratch"
  value       = var.create_template_scratch ? alicloud_ros_template_scratch.template_scratch[0].status : null
}

# =============================================================================
# Resource ID Outputs (for referencing in other modules)
# =============================================================================

output "this_template_id" {
  description = "The ID of the template (created or provided)"
  value       = local.this_template_id
}

output "this_stack_id" {
  description = "The ID of the stack (created or provided)"
  value       = local.this_stack_id
}

output "this_stack_group_id" {
  description = "The ID of the stack group (created or provided)"
  value       = local.this_stack_group_id
}