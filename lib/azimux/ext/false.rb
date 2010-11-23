FalseClass.class_eval do
  def to_css_visibility_by_display
    "none"
  end

  def yesno
    "no"
  end

  def to_bool
    self
  end
end