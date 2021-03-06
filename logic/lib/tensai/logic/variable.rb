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
        name: Name,
        type: Tensai::Types::Instance(Class).default { Entity }
      )

      def accepts?(value)
        return value.type <= type if value.is_a? Variable

        value.is_a? type
      end

      def inspect
        "?#{name} - #{type.name.split('::').last}"
      end
    end
  end
end
