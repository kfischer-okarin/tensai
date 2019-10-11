# frozen_string_literal: true

require_relative '../../spec_helper'

module Tensai
  module Logic
    RSpec.describe Entity do
      describe '.name' do
        it 'returns "Entity" for the Entity class' do
          expect(Entity.name).to eq 'Entity'
        end

        it 'returns the specified name for a subtype' do
          subtype = Entity.create_subtype(:black_wizard)
          expect(subtype.name).to eq 'BlackWizard'
        end
      end
    end
  end
end
