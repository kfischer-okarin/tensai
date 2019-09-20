# frozen_string_literal: true

require 'dry-types'

module Tensai
  # Types for argument validations
  module Types
    include Dry.Types()
  end
end

Dry::Logic::Predicates.predicate('fulfills?') do |condition, input|
  condition.call(input)
end
