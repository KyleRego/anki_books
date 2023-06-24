# frozen_string_literal: true

TEST_BASIC_NOTE_FRONT = "What sound does a cat make?"
TEST_BASIC_NOTE_BACK = "The cat says meow."

FactoryBot.define do
  factory :basic_note do
    front { TEST_BASIC_NOTE_FRONT }
    back { TEST_BASIC_NOTE_BACK }
    ordinal_position { article.notes_count }
  end
end
