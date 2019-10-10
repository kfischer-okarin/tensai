# frozen_string_literal: true

require_relative '../../spec_helper'

module Tensai
  module Logic
    RSpec.describe Predicate do
      describe 'Constructor' do
        it 'cannot have variables with the same name' do
          expect {
            Predicate.new(name: :p, variables: [build(:variable, name: :x), build(:variable, name: :x)])
          }.to raise_error ArgumentError
        end
      end

      describe '#accepts?' do
        let(:predicate) { Predicate.new(name: :p, variables: variables) }
        let(:variables) { [build(:variable, name: :x), build(:variable, name: :y)] }

        it 'accepts valid values' do
          expect(predicate.accepts?(x: build(:entity), y: build(:entity))).to be true
        end

        it 'does not accept unknown values' do
          expect(predicate.accepts?(x: build(:entity), y: build(:entity), z: build(:entity))).to be false
        end

        it 'does not accept values of wrong type' do
          expect(predicate.accepts?(x: build(:entity), y: 1, z: build(:entity))).to be false
        end

        it 'needs all values' do
          expect(predicate.accepts?(x: build(:entity))).to be false
        end
      end
    end
  end
end
