# frozen_string_literal: true

FactoryBot.define do
  factory :entity, class: Tensai::Logic::Entity do
    sequence(:name) { |n| "e_#{n}".to_sym }

    initialize_with { new(name: name) }
  end
end
