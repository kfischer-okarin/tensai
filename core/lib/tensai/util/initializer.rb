# frozen_string_literal: true

require 'tensai/types'

module Tensai::Util
  # @private
  class Initializer < Module
    def initialize(**args)
      @args = args

      define_method :__check_argument_type do |argument, value|
        args[argument][value]
      end
    end

    def included(klass)
      klass.class_eval initializer_code, __FILE__, __LINE__ + 10
      @args.keys.each do |arg|
        klass.class_eval "attr_reader :#{arg}", __FILE__, __LINE__
      end
    end

    private

    def initializer_code
      <<~CODE
        def initialize(#{initializer_signature})
          #{check_argument_types_code}
          #{assign_instance_variables_code}
        end
      CODE
    end

    def initializer_signature
      @args.keys.map { |arg| "#{arg}:" }.join(', ')
    end

    def check_argument_types_code
      @args.keys.map { |arg| "__check_argument_type(:#{arg}, #{arg})" }.join(';')
    end

    def assign_instance_variables_code
      @args.keys.map { |arg| "@#{arg} = #{arg}" }.join(';')
    end
  end
end
