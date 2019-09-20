# frozen_string_literal: true

require 'tensai/types'
require 'tensai/util/initializer'

module Tensai
  module Agents
    # Agent
    class Agent
      include Util::Initializer.new(
        sensors: Types::Strict::Array
      )
    end
  end
end
