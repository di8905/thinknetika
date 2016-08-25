module Accessors

  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name.to_sym) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @history[var_name] ? @history[var_name] << value : @history[var_name] = [value]
        end
        define_method("#{name}_history".to_sym) { @history[var_name] }
      end
    end

  end

  module InstanceMethods
    define_method(:initialize) { instance_variable_set(:@history, {})}
  end
end

class Test
  include Accessors
  attr_accessor_with_history :vwh, :ttest
end

t = Test.new
p t.vwh = 6
p t.vwh = "demon"
p t.vwh_history
p t.ttest = "13"
p t.ttest = "lksdjflksf"
p t.ttest_history
