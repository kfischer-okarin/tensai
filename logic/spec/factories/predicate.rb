# frozen_string_literal: true

FactoryBot.define do
  factory :predicate, class: Tensai::Logic::Predicate do
    sequence(:name) { |n| "p_#{n}".to_sym }
    variables { build_list(:variable, 2) }

    initialize_with { new(name: name, variables: variables) }
  end
end
