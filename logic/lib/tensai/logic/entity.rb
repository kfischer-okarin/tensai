# frozen_string_literal: true

require 'tensai/types'
require 'tensai/util/initializer'

module Tensai
  module Logic
    #
    # Entity
    #
    class Entity
      include Util::Initializer.new(
        name: Types::Strict::Symbol
      )
    end
  end
end
