NilClass.class_eval do
  def yesno
    "unknown"
  end

  def to_bool
    false
  end
end
