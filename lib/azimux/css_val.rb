module Azimux
  class CssVal
    attr_reader :magnitude, :units

    public
    def initialize(*vals)
      if vals.size == 1
        c = to_css_val(vals[0])
        vals = [c.magnitude, c.units]
      end

      @magnitude, @units = vals
    end

    def to_s
      magnitude.to_s + units
    end

    def self.extract_value_units(css_string)
      m = /^\s*(-?\d+)\s*([^\d]*)$/.match(css_string)
      [m[1].to_i, m[2]]
    end

    def /(dividend)
      do_op("/", dividend)
    end

    def -diff
      self + -diff
    end

    def -@
      CssVal.new(-magnitude, units)
    end

    def +(other_val)
      do_op("+", other_val)
    end

    def *(other_val)
      do_op('*', other_val)
    end

    private
    def do_op(op, other_val)
      other_val = to_css_val(other_val)

      if units !=  other_val.units
        raise "units mismatch!"
      end

      CssVal.new(magnitude.send(op, other_val.magnitude), units)
    end

    def to_css_val(oval)
      case oval
      when String
        CssVal.new(*self.class.extract_value_units(oval))
      when Integer
        CssVal.new(oval, units)
      when CssVal
        oval
      else
        raise "can't cast #{oval.class} to CssVal"
      end
    end
  end
end