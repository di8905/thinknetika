module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@validations, {})
  end

  module ClassMethods
    def validate(attribute, validation_type, *params)
      class_variable_get(:@@validations)[[attribute, validation_type]] = *params
    end
  end

  module InstanceMethods
    def validate!
      self.class.class_variable_get(:@@validations).each_pair do |validation, params|
        value = instance_variable_get("@#{validation[0]}".to_sym)
        validation_type = validation[1]
        send("validate_#{validation_type}".to_sym, value, *params)
      end
    end

    def validate_presence(value)
      raise StandardError, "Attribute cannot be empty or blank" unless value && !value.strip.empty?
    end

    def validate_format(value, *params)
      format = params[0]
      raise StandardError, "Wrong attribute format" unless value =~ format
    end

    def validate_type(value, *params)
      type = params[0]
      raise StandardError, "Wrong attribute type" unless value.is_a?(type)
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
