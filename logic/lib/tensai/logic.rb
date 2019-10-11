# frozen_string_literal: true

require 'tensai/types'

module Tensai
  # Logic and Reasoning
  module Logic
    Name = Types::Strict::Symbol
  end
end

require 'tensai/logic/entity'
require 'tensai/logic/formula'
require 'tensai/logic/formulas'
require 'tensai/logic/predicate'
require 'tensai/logic/variable'
