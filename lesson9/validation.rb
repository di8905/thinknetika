module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@validations, {})
  end

  module ClassMethods
    def validate(attribute, validation_type, *params)
      class_variable_get(:@@validations)[attribute] = [validation_type, *params]
    end
  end

  module InstanceMethods
  end
  # def validate!(attribute, template)
  #   raise 'Wrong input format' if attribute !~ template
  #   true
  # end
end
