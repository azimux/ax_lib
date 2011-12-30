Array.class_eval do
  def join_and
    case size
    when 0 then return ''
    when 1 then return self[0]
    else
      l = last
      f = self[0..(size - 2)]
      return safe_join(safe_join(f, ', '), " and ".html_safe, l)
    end
  end
end
