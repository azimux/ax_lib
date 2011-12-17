module Azimux
  module VarHolder
    def method_missing(sym, *args)
      if sym.to_s !~ /=$/
        super
      else
        cattr_accessor sym.to_s.gsub(/=$/, '').to_sym
        if self.respond_to?(sym)
          self.send(sym,*args)
        else
          super
        end
      end
    end
  end
end