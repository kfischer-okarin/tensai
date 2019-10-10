# frozen_string_literal: true

require 'set'

require 'tensai/types'
require 'tensai/util/initializer'

require_relative 'variable'

module Tensai
  module Logic
    #
    # Predicate
    #
    class Predicate
      include Util::Initializer.new(
        name: Name,
        variables: Tensai::Types::Array.of(Tensai::Types::Instance(Variable))
      )

      def after_initialize
        raise ArgumentError, 'All variable names must be unique' if variable_names.size < variables.size
      end

      def accepts?(values)
        Set.new(values.keys) == variable_names &&
          variables.all? { |v| v.accepts? values[v.name] }
      end

      def inspect
        "(#{name} #{variables.map(&:inspect).join(' ')})"
      end

      private

      def variable_names
        @variable_names ||= Set.new(variables.map(&:name))
      end
    end
  end
end
