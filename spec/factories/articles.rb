# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

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

  factory :neuroplasticity_article, class: "Article" do
    title { "Neuroplasticity" }
    book { create(:book) }
    ordinal_position { book.articles_count }
    content { Rails.root.join("spec/fixtures/neuroplasticity_article_content.txt").read }
  end
end
