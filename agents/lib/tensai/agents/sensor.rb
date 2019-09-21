# frozen_string_literal: true

require 'tensai/types'
require 'tensai/util/initializer'

module Tensai
  module Agents
    #
    # Agent sensor
    #
    class Sensor
      include Util::Initializer.new(
        agent: Types::Any
      )

      #
      # Process input from environment and produce percepts.
      # (see #percepts)
      #
      # @param input Sensoric input from the environment
      #
      def process_input(input) # rubocop:disable Lint/UnusedMethodArgument
        raise NotImplementedError
      end

      #
      # Percepts produced by recent sensor input.
      #
      # @return [Enumerable] List of percepts
      #
      def percepts
        raise NotImplementedError
      end
    end
  end
end
