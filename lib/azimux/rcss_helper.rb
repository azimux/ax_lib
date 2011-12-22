module Azimux
  module RcssHelper
    def css(*vals)
      CssVal.new(*vals)
    end
  end
end