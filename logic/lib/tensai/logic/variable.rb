# frozen_string_literal: true

require 'tensai/types'
require 'tensai/util/initializer'

require_relative 'entity'

module Tensai
  module Logic
    #
    # Variable
    #
    class Variable
      include Util::Initializer.new(
        name: Tensai::Types::Strict::Symbol,
        type: Tensai::Types::Instance(Class).default { Entity }
      )

      def accepts?(value)
        value.is_a? type
      end

      def inspect
        "#{type.inspect} ?#{name}"
      end
    end
  end
end
