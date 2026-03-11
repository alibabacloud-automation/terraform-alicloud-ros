# =============================================================================
# ROS Template Outputs
# =============================================================================

output "template_id" {
  description = "The ID of the created ROS template"
  value       = module.ros_complete.template_id
}

output "template_name" {
  description = "The name of the created ROS template"
  value       = module.ros_complete.template_name
}

# =============================================================================
# ROS Stack Outputs
# =============================================================================

output "stack_id" {
  description = "The ID of the created ROS stack"
  value       = module.ros_complete.stack_id
}

output "stack_name" {
  description = "The name of the created ROS stack"
  value       = module.ros_complete.stack_name
}

output "stack_status" {
  description = "The status of the created ROS stack"
  value       = module.ros_complete.stack_status
}

# =============================================================================
# ROS Stack Group Outputs
# =============================================================================

output "stack_group_id" {
  description = "The ID of the created ROS stack group"
  value       = module.ros_complete.stack_group_id
}

output "stack_group_name" {
  description = "The name of the created ROS stack group"
  value       = module.ros_complete.stack_group_name
}

output "stack_group_status" {
  description = "The status of the created ROS stack group"
  value       = module.ros_complete.stack_group_status
}

# =============================================================================
# ROS Stack Instance Outputs
# =============================================================================

output "stack_instance_id" {
  description = "The ID of the created stack instance"
  value       = module.ros_complete.stack_instance_id
}

output "stack_instance_status" {
  description = "The status of the created stack instance"
  value       = module.ros_complete.stack_instance_status
}

output "stack_instance_account_id" {
  description = "The account ID of the created stack instance"
  value       = module.ros_complete.stack_instance_account_id
}

output "stack_instance_region_id" {
  description = "The region ID of the created stack instance"
  value       = module.ros_complete.stack_instance_region_id
}

# =============================================================================
# ROS Change Set Outputs
# =============================================================================

output "change_set_id" {
  description = "The ID of the created change set"
  value       = module.ros_complete.change_set_id
}

output "change_set_name" {
  description = "The name of the created change set"
  value       = module.ros_complete.change_set_name
}

output "change_set_status" {
  description = "The status of the created change set"
  value       = module.ros_complete.change_set_status
}

# =============================================================================
# ROS Template Scratch Outputs
# =============================================================================

output "template_scratch_id" {
  description = "The ID of the created template scratch"
  value       = module.ros_complete.template_scratch_id
}

output "template_scratch_status" {
  description = "The status of the created template scratch"
  value       = module.ros_complete.template_scratch_status
}
