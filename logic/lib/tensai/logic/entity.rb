# frozen_string_literal: true

require 'tensai/util/initializer'

module Tensai
  module Logic
    #
    # Entity
    #
    class Entity
      include Util::Initializer.new(
        name: Name
      )
    end
  end
end
