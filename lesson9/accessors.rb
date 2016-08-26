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

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name.to_sym) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise TypeError unless value.is_a?(type)
        instance_variable_set(var_name, value)
      end
    end
  end

  module InstanceMethods
    define_method(:initialize) { instance_variable_set(:@history, {})}
  end
end

class Test
  include Accessors
  strong_attr_accessor :str, String
  strong_attr_accessor :int, Integer
  # attr_accessor_with_history :vwh, :ttest
end

t = Test.new
t.str = 'ququ'
t.int = 1

# p t.vwh = 6
# p t.vwh = "demon"
# p t.vwh_history
# p t.ttest = "13"
# p t.ttest = "lksdjflksf"
# p t.ttest_history
