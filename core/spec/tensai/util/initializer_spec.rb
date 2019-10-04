# frozen_string_literal: true

require_relative '../../spec_helper'

require 'tensai/util/initializer'

module Tensai
  module Util
    RSpec.describe Initializer do
      let(:klass) { Class.new }

      shared_examples 'common properties' do
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

      context 'Required arguments' do
        before do
          klass.include Initializer.new(arg: Types::Strict::String)
        end

        include_examples 'common properties'

        it 'requires the argument' do
          expect { klass.new }.to raise_error ArgumentError
        end

        context 'When the parent class already includes an Initializer' do
          context 'with different arguments' do
            let(:klass) {
              parent = Class.new
              parent.include Initializer.new(id: Types::Strict::Integer)
              Class.new parent
            }

            it 'accepts the right argument of the right type' do
              instance = klass.new(arg: 'aa', id: 1)
              expect(instance).to have_attributes(arg: 'aa', id: 1)
            end

            it 'does not accept other arguments' do
              expect { klass.new(b: 'aa') }.to raise_error ArgumentError
            end

            it 'does not accept positional arguments' do
              expect { klass.new('aa') }.to raise_error ArgumentError
            end

            it 'does not accept arguments of wrong type' do
              expect { klass.new(arg: 4, id: 'aa') }.to raise_error Dry::Types::CoercionError
            end
          end

          context 'with the same arguments' do
            let(:klass) {
              parent = Class.new
              parent.include Initializer.new(arg: Types::Strict::Integer)
              Class.new parent
            }

            it 'uses the type of the child class' do
              instance = klass.new(arg: 'aa')
              expect(instance).to have_attributes(arg: 'aa')
            end
          end
        end
      end

      context 'Optional arguments' do
        before do
          klass.include Initializer.new(arg: Types::Strict::String.optional)
        end

        include_examples 'common properties'

        it 'does not require the argument' do
          instance = klass.new
          expect(instance).to have_attributes(arg: nil)
        end
      end

      context 'Arguments with default value' do
        before do
          klass.include Initializer.new(arg: Types::Strict::String.default { 'b' })
        end

        include_examples 'common properties'

        it 'does not require the argument' do
          instance = klass.new
          expect(instance).to have_attributes(arg: 'b')
        end
      end
    end
  end
end
