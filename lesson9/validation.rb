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
       attribute, validation_type = validation
       send("validate_#{validation_type}".to_sym, attribute, *params)
      end
    end

    def validate_presence(attribute)
      value = instance_variable_get("@#{attribute}".to_sym)
      raise "Attribute cannot be empty or blank" unless value && !value.strip.empty?
    end

    def validate_format(attribute, *params)
      p "checking format"
    end

    def validate_type(attribute, *params)
      p "checking type"
    end
  end
  # def validate!(attribute, template)
  #   raise 'Wrong input format' if attribute !~ template
  #   true
  # end
end
