# frozen_string_literal: true

require 'tensai/types'
require 'tensai/util/initializer'

module Tensai
  module Agents
    #
    # Agent
    #
    class Agent
      include Util::Initializer.new(
        sensors: Types::Strict::Array
      )

      #
      # Execute one cycle of agent activity.
      # This includes processing percepts, decision making and acting.
      #
      # @param context Execution context
      #
      def act(context) # rubocop:disable Lint/UnusedMethodArgument
        raise NotImplementedError
      end
    end
  end
end
