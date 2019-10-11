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

      def inspect
        "#{self.class.to_s.split('::').last}(#{name})"
      end
    end
  end
end
