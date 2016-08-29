module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
  end
  # def validate!(attribute, template)
  #   raise 'Wrong input format' if attribute !~ template
  #   true
  # end
end
