module Validation

  protected

  def validate!(attribute, template)
    raise "Wrong input format" if attribute !~ template
    true
  end
end
