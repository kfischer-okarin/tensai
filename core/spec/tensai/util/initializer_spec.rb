# frozen_string_literal: true

require_relative '../../spec_helper'

require 'tensai/util/initializer'

module Tensai
  module Util
    RSpec.describe Initializer do
      let(:klass) { Class.new }

      before do
        klass.include Initializer.new(arg: Types::Strict::String)
      end

      it 'accepts the right argument of the right type' do
        instance = klass.new(arg: 'aa')
        expect(instance).to have_attributes(arg: 'aa')
      end

      it 'does not accept other arguments' do
        expect { klass.new(b: 'aa') }.to raise_error ArgumentError
      end

      it 'does not accept positional arguments' do
        expect { klass.new('aa') }.to raise_error ArgumentError
      end

      it 'does not accept arguments of wrong type' do
        expect { klass.new(arg: 4) }.to raise_error Dry::Types::CoercionError
      end
    end
  end
end
