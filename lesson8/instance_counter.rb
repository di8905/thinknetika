module InstanceCounter

  def  self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
  end

  module ClassMethods

    def instances
      @instances ||=0
    end

    def instances=(count)
      @instances = count
    end
  end

  module InstanceMethods

    private
    def register_instance
      self.class.instances += 1
    end
  end
end
