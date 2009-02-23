require 'test/unit/assertions'
module Test
  module Unit
    #--
    # FIXME: no Proc#binding in Ruby 2, must change this API
    #++
    module Assertions
      def assert_changed(expressions, message = nil, &block)
        expression_evaluations = Array(expressions).map do |expression|
          lambda do
            eval(expression, block.__send__(:binding))
          end
        end

        original_values = expression_evaluations.inject([]) { |memo, expression| memo << expression.call }
        yield
        expression_evaluations.each_with_index do |expression, i|
          assert_not_equal original_values[i], expression.call, message
        end
      end
    end
  end
end