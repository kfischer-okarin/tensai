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
          let(:variable) { Variable.new(name: :x, type: Integer) }

          it 'accepts values of the specified type' do
            expect(variable.accepts?(2)).to eq true
          end
        end
      end
    end
  end
end
