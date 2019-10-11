# frozen_string_literal: true

require 'dry/inflector'

require 'tensai/util/initializer'

module Tensai
  module Logic
    #
    # Logical entity which appears in predicates
    #
    class Entity
      include Util::Initializer.new(
        name: Name
      )

      def inspect
        "#{self.class.name}(#{name})"
      end

      class << self
        #
        # Name of entity class
        #
        def name
          @name || 'Entity'
        end

        #
        # Create a subtype with the specified name
        #
        def create_subtype(name)
          Class.new(self) do
            @name = Dry::Inflector.new.classify(name.to_s)
          end
        end
      end
    end
  end
end
