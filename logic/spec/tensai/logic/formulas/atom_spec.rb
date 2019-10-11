# frozen_string_literal: true

require_relative '../../../spec_helper'

module Tensai
  module Logic
    module Formulas
      RSpec.describe Atom do
        describe 'Constructor' do
          let(:predicate) { build(:predicate, variables: [build(:variable, name: :x)]) }

          it 'accepts values that are accepted by the predicate' do
            expect {
              Atom.new(predicate: predicate, values: { x: build(:entity) })
            }.not_to raise_error
          end

          it 'does not accept values that are rejected by the predicate' do
            expect {
              Atom.new(predicate: predicate, values: { y: build(:entity) })
            }.to raise_error ArgumentError
          end
        end
      end
    end
  end
end
