# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id               :uuid             not null, primary key
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  system           :boolean          default(FALSE), not null
#  book_id          :uuid             not null
#  ordinal_position :integer          not null
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#
FactoryBot.define do
  factory :article do
    title { "Hello World" }
    book { create(:book) }
    ordinal_position { book.articles_count }
  end
end
