# frozen_string_literal: true

require 'tensai/types'

module Tensai::Util
  # @private
  class Initializer < Module
    attr_reader :args

    def initialize(**args)
      @args = args
    end

    def included(klass)
      @args.keys.each do |arg|
        klass.class_eval "attr_reader :#{arg}", __FILE__, __LINE__
      end

      all_args = all_args_for(klass)

      klass.instance_eval do
        define_method :__check_argument_type do |argument, value|
          all_args[argument][value]
        end
      end

      klass.class_eval InitializeMethod.new(all_args).code, __FILE__, __LINE__ + 11
    end

    private

    def all_args_for(klass)
      parent_initializers = klass.ancestors.select { |a| a.is_a? Initializer }

      parent_initializers.map(&:args)
                         .reduce(args) { |result, parent_args| parent_args.merge result }
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
            #{check_argument_types_code}
            #{assign_instance_variables_code}
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
        args.reject { |_, type| type.optional? }.to_h
      end

      def optional_args
        args.select { |_, type| type.optional? }.to_h
      end

      def check_argument_types_code
        args.keys.map { |arg| "__check_argument_type(:#{arg}, #{arg})" }.join(';')
      end

      def assign_instance_variables_code
        args.keys.map { |arg| "@#{arg} = #{arg}" }.join(';')
      end
    end
  end
end
