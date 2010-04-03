Integer.class_eval do
  def Integer.get_b64_chars
    @b64_chars ||= "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"
  end  

  def Integer.get_b64_ints
    unless defined? @b64_ints
      @b64_ints = {}
      i = 0
      get_b64_chars.each_byte do |c|
        @b64_ints[c] = i
        i += 1
      end
    end
    
    @b64_ints
  end
  
  def to_b64
    raise "to_b64 can't handle #{self.to_s}" if self.to_i < 0
    return Integer.get_b64_chars[0].chr.to_s if self.to_i == 0
    
    retval = ""
    input_copy = self.to_i
    zeroes = true
    chunks = (self.to_s(2).length / 6) + 1
    
    (chunks - 1).downto(0) do |i|
      j = 63 & (input_copy >> (i * 6))

      if (j != 0 || !zeroes) #we want to skip all leading 0's
        retval << Integer.get_b64_chars[j].chr.to_s
        zeroes = false
      end
    end

    retval == "" ? raise("wtf?  invalid integer sent to to_b64") : retval
  end
  
  def Integer.from_b64(input_string)
    retval = 0;

    i = 0
    
    input_string.reverse.each_byte { |c| 
      retval += (get_b64_ints[c] << (6 * i))
      i += 1
    }
    retval
  end
end
