# =============================================================================
# Resource Creation Control Variables
# =============================================================================

variable "create_template" {
  description = "Whether to create a new ROS template. If false, an existing template ID must be provided."
  type        = bool
  default     = false
}

variable "template_id" {
  description = "The ID of an existing ROS template. Required when create_template is false."
  type        = string
  default     = null
}

variable "create_stack" {
  description = "Whether to create a new ROS stack. If false, an existing stack ID must be provided."
  type        = bool
  default     = true
}

variable "stack_id" {
  description = "The ID of an existing ROS stack. Required when create_stack is false."
  type        = string
  default     = null
}

variable "create_stack_group" {
  description = "Whether to create a new ROS stack group. If false, an existing stack group ID must be provided."
  type        = bool
  default     = false
}

variable "stack_group_id" {
  description = "The ID of an existing ROS stack group. Required when create_stack_group is false."
  type        = string
  default     = null
}

variable "create_stack_instance" {
  description = "Whether to create a ROS stack instance in the stack group."
  type        = bool
  default     = false
}

variable "create_change_set" {
  description = "Whether to create a ROS change set for the stack."
  type        = bool
  default     = false
}

variable "create_template_scratch" {
  description = "Whether to create a ROS template scratch for resource import or architecture replication."
  type        = bool
  default     = false
}

# =============================================================================
# Template Configuration
# =============================================================================

variable "template_config" {
  description = "Configuration for the ROS template. The attributes 'template_name' and 'template_body' are required when create_template is true."
  type = object({
    template_name = string
    description   = optional(string, "ROS template created by Terraform")
    template_body = optional(string, null)
    template_url  = optional(string, null)
  })
  default = {
    template_name = null
    template_body = null
  }
}

# =============================================================================
# Stack Configuration
# =============================================================================

variable "stack_config" {
  description = "Configuration for the ROS stack. The attributes 'stack_name' and 'template_body' are required when create_stack is true."
  type = object({
    stack_name                      = string
    template_body                   = optional(string, null)
    template_url                    = optional(string, null)
    template_version                = optional(string, null)
    disable_rollback                = optional(bool, false)
    timeout_in_minutes              = optional(number, 60)
    stack_policy_body               = optional(string, null)
    stack_policy_url                = optional(string, null)
    stack_policy_during_update_body = optional(string, null)
    stack_policy_during_update_url  = optional(string, null)
    ram_role_name                   = optional(string, null)
    replacement_option              = optional(string, null)
    create_option                   = optional(string, null)
    deletion_protection             = optional(string, "Disabled")
    retain_all_resources            = optional(bool, null)
    use_previous_parameters         = optional(bool, null)
    notification_urls               = optional(list(string), null)
    retain_resources                = optional(list(string), null)
  })
  default = {
    stack_name    = null
    template_body = null
  }
}

variable "stack_parameters" {
  description = "List of parameters for the ROS stack."
  type = list(object({
    parameter_key   = string
    parameter_value = string
  }))
  default = []
}

# =============================================================================
# Stack Group Configuration
# =============================================================================

variable "stack_group_config" {
  description = "Configuration for the ROS stack group. The attributes 'stack_group_name' and 'template_body' are required when create_stack_group is true."
  type = object({
    stack_group_name         = string
    description              = optional(string, "ROS stack group created by Terraform")
    template_body            = optional(string, null)
    template_url             = optional(string, null)
    template_id              = optional(string, null)
    template_version         = optional(string, null)
    administration_role_name = optional(string, null)
    execution_role_name      = optional(string, null)
    permission_model         = optional(string, null)
    resource_group_id        = optional(string, null)
    capabilities             = optional(list(string), null)
    auto_deployment = optional(object({
      enabled                          = bool
      retain_stacks_on_account_removal = bool
    }), null)
  })
  default = {
    stack_group_name = null
    template_body    = null
  }
}

variable "stack_group_parameters" {
  description = "List of parameters for the ROS stack group."
  type = list(object({
    parameter_key   = string
    parameter_value = string
  }))
  default = []
}

# =============================================================================
# Stack Instance Configuration
# =============================================================================

variable "stack_instance_config" {
  description = "Configuration for the ROS stack instance."
  type = object({
    stack_instance_account_id = optional(string, null)
    stack_instance_region_id  = optional(string, null)
    operation_description     = optional(string, "Stack instance operation via Terraform")
    operation_preferences     = optional(string, null)
    timeout_in_minutes        = optional(string, "60")
    retain_stacks             = optional(string, "false")
  })
  default = {}
}

variable "stack_instance_parameter_overrides" {
  description = "List of parameter overrides for the ROS stack instance."
  type = list(object({
    parameter_key   = string
    parameter_value = string
  }))
  default = []
}

# =============================================================================
# Change Set Configuration
# =============================================================================

variable "change_set_config" {
  description = "Configuration for the ROS change set. The attributes 'change_set_name', 'stack_name', 'change_set_type', and 'template_body' are required when create_change_set is true."
  type = object({
    change_set_name                 = string
    stack_name                      = string
    change_set_type                 = string
    description                     = optional(string, "ROS change set created by Terraform")
    template_body                   = optional(string, null)
    template_url                    = optional(string, null)
    disable_rollback                = optional(bool, null)
    timeout_in_minutes              = optional(number, null)
    stack_policy_body               = optional(string, null)
    stack_policy_url                = optional(string, null)
    stack_policy_during_update_body = optional(string, null)
    stack_policy_during_update_url  = optional(string, null)
    ram_role_name                   = optional(string, null)
    replacement_option              = optional(string, null)
    use_previous_parameters         = optional(bool, null)
    notification_urls               = optional(list(string), null)
  })
  default = {
    change_set_name = null
    stack_name      = null
    change_set_type = null
    template_body   = null
  }
}

variable "change_set_parameters" {
  description = "List of parameters for the ROS change set."
  type = list(object({
    parameter_key   = string
    parameter_value = string
  }))
  default = []
}

# =============================================================================
# Template Scratch Configuration
# =============================================================================

variable "template_scratch_config" {
  description = "Configuration for the ROS template scratch. The attribute 'template_scratch_type' is required when create_template_scratch is true."
  type = object({
    template_scratch_type = string
    description           = optional(string, "ROS template scratch created by Terraform")
    execution_mode        = optional(string, null)
    logical_id_strategy   = optional(string, null)
    source_resource_group = optional(object({
      resource_group_id    = string
      resource_type_filter = optional(list(string), null)
    }), null)
    source_tag = optional(object({
      resource_tags        = map(string)
      resource_type_filter = optional(list(string), null)
    }), null)
  })
  default = {
    template_scratch_type = null
  }
}

variable "template_scratch_preference_parameters" {
  description = "List of preference parameters for the ROS template scratch."
  type = list(object({
    parameter_key   = string
    parameter_value = string
  }))
  default = []
}

variable "template_scratch_source_resources" {
  description = "List of source resources for the ROS template scratch."
  type = list(object({
    resource_id   = string
    resource_type = string
  }))
  default = []
}

# =============================================================================
# Common Configuration
# =============================================================================

variable "common_tags" {
  description = "A map of common tags to assign to all resources."
  type        = map(string)
  default     = {}
}