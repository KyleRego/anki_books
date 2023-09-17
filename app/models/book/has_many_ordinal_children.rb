# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Concrete implementations for the abstract template methods in
# HasManyOrdinalChildrenBase for Article
module Book::HasManyOrdinalChildren
  include HasManyOrdinalChildrenBase

  private

  def ordinal_positions
    ordered_articles.pluck(:ordinal_position)
  end

  def expected_ordinal_positions
    (0...articles_count).to_a
  end

  def child_belongs_to_parent?(child:)
    return false if child.new_record?

    articles.include?(child)
  end

  def ordinally_positioned_children
    articles
  end

  def ordinally_positioned_children_count
    articles_count
  end
end
