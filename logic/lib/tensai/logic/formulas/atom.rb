# frozen_string_literal: true

require 'tensai/types'
require 'tensai/util/initializer'

require_relative '../predicate'

module Tensai
  module Logic
    module Formulas
      #
      # Atomic formula
      #
      class Atom
        include Util::Initializer.new(
          predicate: Tensai::Types::Instance(Predicate),
          values: Tensai::Types::Hash
        )

        def after_initialize
          raise ArgumentError, "Invalid values #{values} for predicate #{predicate}" unless predicate.accepts? values
        end

        def inspect
          "(#{predicate.name} #{values.map { |name, value| "#{name}: #{value.inspect}" }.join(', ')})"
        end
      end
    end
  end
end
