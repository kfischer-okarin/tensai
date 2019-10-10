# frozen_string_literal: true

FactoryBot.define do
  factory :variable, class: Tensai::Logic::Variable do
    sequence(:name) { |n| "variable_#{n}".to_sym }

    initialize_with { new(name: name) }
  end
end
