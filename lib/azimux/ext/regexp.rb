Regexp.class_eval do
  def matches s
    orig = s
    retval = []
    start = 0

    while s =~ self
      retval << MatchesMatch.new(start, $~)
      start += $~.end(0)

      s = if s == $'
        $'[1..-1]
      else
        $'
      end
    end

    retval
  end
end

raise "already defined Matches" if defined?(MatchesMatch)

class MatchesMatch
  attr_accessor :start, :match

  def initialize start, match
    self.start = start
    self.match = match
  end

  [:begin, :end].each do |meth|
    define_method meth do |*n|
      match.send(meth, n[0] || 0) + start
    end
  end

  def method_missing method, *args
    if [
        :[]
      ].index method
      match.send(method, *args)
    else
      super method, *args
    end
  end
end