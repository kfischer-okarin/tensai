# frozen_string_literal: true

require 'tensai/types'
require 'tensai/util/initializer'

module Tensai
  module Agents
    # Agent sensor
    class Sensor
      include Util::Initializer.new(
        agent: Types::Any
      )

      # Process input from environment.
      #
      # The sensor should turn this input into percepts.
      def process_input(_input)
        raise NotImplementedError
      end

      # Percepts produced from recent input
      def percepts
        raise NotImplementedError
      end
    end
  end
end
