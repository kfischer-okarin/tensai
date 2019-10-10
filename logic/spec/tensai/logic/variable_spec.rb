# frozen_string_literal: true

require_relative '../../spec_helper'

module Tensai
  module Logic
    RSpec.describe Variable do
      describe '#accept?' do
        context 'without specified type' do
          let(:variable) { Variable.new(name: :x) }

          it 'accepts entities' do
            expect(variable.accepts?(build(:entity))).to eq true
          end

          it 'does not accept other values' do
            expect(variable.accepts?(2)).to eq false
          end
        end

        context 'with specified type' do
          let(:variable) { Variable.new(name: :x, type: Numeric) }

          it 'accepts values of the specified type' do
            expect(variable.accepts?(2)).to eq true
          end

          it 'accepts variables of same type' do
            expect(variable.accepts?(Variable.new(name: :y, type: Numeric))).to eq true
          end

          it 'accepts variables of subtypes' do
            expect(variable.accepts?(Variable.new(name: :y, type: Integer))).to eq true
          end
        end
      end
    end
  end
end
