# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: domains
#
#  id               :uuid             not null, primary key
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :uuid             not null
#  parent_domain_id :uuid
#
# Foreign Keys
#
#  fk_rails_...  (parent_domain_id => domains.id)
#  fk_rails_...  (user_id => users.id)
#
class Domain < ApplicationRecord
  belongs_to :user, optional: false
  has_many :books_domains, dependent: :destroy
  has_many :books, -> { order(:title) }, through: :books_domains

  belongs_to :parent_domain, optional: true, class_name: "Domain", inverse_of: :domains
  has_many :domains, foreign_key: :parent_domain_id, inverse_of: :parent_domain, dependent: nil

  validates :title, presence: true

  ##
  # Returns all basic notes of the domain's books and child domains
  # (including nested) in a consistent order
  def ordered_notes
    query = <<~SQL.squish
      WITH RECURSIVE domain_hierarchy AS (
        SELECT id, title, parent_domain_id FROM domains WHERE id = ?
        UNION
        SELECT d.id, d.title, d.parent_domain_id FROM domains d
        JOIN domain_hierarchy dh ON d.parent_domain_id = dh.id
      )
      SELECT DISTINCT bn.*, dh.title, b.title, a.ordinal_position AS article_position
      FROM basic_notes bn
      JOIN articles a ON bn.article_id = a.id
      JOIN books b ON a.book_id = b.id
      JOIN books_domains bd ON b.id = bd.book_id
      JOIN domain_hierarchy dh ON bd.domain_id = dh.id
      ORDER BY dh.title, b.title, article_position, bn.ordinal_position
    SQL

    BasicNote.find_by_sql([query, id])
  end
end
