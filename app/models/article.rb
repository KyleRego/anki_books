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
class Article < ApplicationRecord
  belongs_to :book

  has_rich_text :content

  has_many :basic_notes, dependent: :destroy
  has_many :ordered_notes, -> { order(:ordinal_position) }, class_name: "BasicNote", inverse_of: :article, dependent: :destroy

  validates :title, presence: true
  validates :ordinal_position, presence: true, uniqueness: { scope: :book_id }

  def notes_count
    basic_notes.count
  end
end
