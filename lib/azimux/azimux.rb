module Azimux
  PGSMALLINTMAX = 2 ** 15
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]+$/i
  VERIFY_CODE_LENGTH = 16
     
  def self.generate_verify_code
    chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    
    retval = ""
    
    VERIFY_CODE_LENGTH.times do 
      retval << chars[rand(chars.length)]
    end
    retval
  end
end

class TrueClass
  def to_css_visibility_by_display
    ""
  end
  
  def yesno
    "yes"
  end
end
class FalseClass
  def to_css_visibility_by_display
    "none"
  end
  
  def yesno
    "no"
  end
end

class NilClass
  def yesno
    ""
  end
end

class Array
  def join_and
    case size
    when 0 then return ''
    when 1 then return self[0]
    else 
      l = last
      f = self[0..(size - 2)]
      return "#{f.join(', ')} and #{l}"
    end
  end
end

class String
  def pluralize_on(count)
    count == 1 ? singularize : pluralize
  end
end

