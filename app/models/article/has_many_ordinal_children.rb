# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Concrete implementations for the abstract template methods in
# HasManyOrdinalChildrenBase for Article
module Article::HasManyOrdinalChildren
  include HasManyOrdinalChildrenBase

  def move_ordinal_child_to_new_parent(child:, new_parent:, new_ordinal_position:)
    raise ArgumentError unless child_belongs_to_parent?(child:)

    removed_article_ordinal_position = child.ordinal_position
    child.update(article: new_parent, ordinal_position: new_parent.basic_notes_count)
    new_parent.reposition_ordinal_child(child:, new_ordinal_position:)
    basic_notes.order(:ordinal_position).where("ordinal_position > ?", removed_article_ordinal_position).each do |basic_note|
      basic_note.update!(ordinal_position: basic_note.ordinal_position - 1)
    end
  end

  # rubocop:disable Metrics/AbcSize

  ##
  # Moves +children+ articles to +new_parent+ and shifts the other
  # articles of self appropriately
  def move_ordinal_children_to_new_parent(children:, new_parent:)
    raise ArgumentError unless new_parent.book == book

    article_ids = children.pluck(:article_id)
    raise ArgumentError unless article_ids.uniq.count == 1 && article_ids.first == id

    children.order(:ordinal_position).each do |basic_note|
      basic_note.update(article: new_parent, ordinal_position: new_parent.basic_notes_count)
    end
    ordered_basic_notes.each_with_index do |basic_note, index|
      basic_note.update(ordinal_position: index)
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def ordinal_positions
    ordered_basic_notes.pluck(:ordinal_position)
  end

  def expected_ordinal_positions
    (0...basic_notes_count).to_a
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
