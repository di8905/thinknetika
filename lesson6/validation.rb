module Validation

  protected
  def validate!(attribute, template)
    raise "Wrong input format" if name !~ template
    true
  end

end
