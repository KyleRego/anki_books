# frozen_string_literal: true

FactoryBot.define do
  factory :concept do
    name { "Concept name" }
    parent_concept { nil }
  end
end
