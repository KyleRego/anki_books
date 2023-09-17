# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Concrete implementations for the abstract template methods in
# HasManyOrdinalChildrenBase for Article
module Article::HasManyOrdinalChildren
  include HasManyOrdinalChildrenBase

  private

  def ordinal_positions
    ordered_basic_notes.pluck(:ordinal_position)
  end

  def expected_ordinal_positions
    (0...notes_count).to_a
  end

  def child_belongs_to_parent?(child:)
    return false if child.new_record?

    basic_notes.include?(child)
  end

  def ordinally_positioned_children
    basic_notes
  end

  def ordinally_positioned_children_count
    basic_notes.count
  end
end
