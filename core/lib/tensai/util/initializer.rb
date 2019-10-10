# frozen_string_literal: true

require 'tensai/types'

module Tensai::Util
  # @private
  #
  # Prepend to classes to insert boilerplate constructor, dry-types typecheck and getters
  #
  class Initializer < Module
    attr_reader :args

    def initialize(**args)
      @args = args
    end

    def included(klass) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      this_class_args = args
      all_args = all_args_for(klass)
      has_parent_initializers = parent_initializers(klass).length > 1

      klass.instance_eval do
        define_method :__check_argument_type do |argument, value|
          type = all_args[argument]
          if type.default? && value.nil?
            instance_variable_set("@#{argument}".to_sym, type[])
          else
            type[value]
          end
        end

        attr_reader(*this_class_args.keys)

        alias_method :__original_initialize, :initialize unless has_parent_initializers
      end

      klass.class_eval InitializeMethod.new(all_args).code, __FILE__, __LINE__ + 11
    end

    private

    def all_args_for(klass)
      parent_initializers(klass).map(&:args)
                                .reduce(args) { |result, parent_args| parent_args.merge result }
    end

    def parent_initializers(klass)
      klass.ancestors.select { |a| a.is_a? Initializer }
    end

    #
    # Generates initialize method code
    #
    class InitializeMethod
      def initialize(args)
        @args = args
      end

      def code
        <<~CODE
          def initialize(#{signature})
            #{assign_instance_variables_code}
            #{check_argument_types_code}
            __original_initialize
          end
        CODE
      end

      private

      attr_reader :args

      def signature
        optional = optional_args.keys.map { |arg| "#{arg}: nil" }
        required = required_args.keys.map { |arg| "#{arg}:" }
        (optional + required).join(', ')
      end

      def required_args
        args.reject { |_, type| optional_arg?(type) }.to_h
      end

      def optional_args
        args.select { |_, type| optional_arg?(type) }.to_h
      end

      def check_argument_types_code
        args.keys.map { |arg| "__check_argument_type(:#{arg}, #{arg})" }.join(';')
      end

      def assign_instance_variables_code
        args.keys.map { |arg| "@#{arg} = #{arg}" }.join(';')
      end

      def optional_arg?(arg_type)
        arg_type.optional? || arg_type.default?
      end
    end
  end
end
