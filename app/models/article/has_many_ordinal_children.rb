# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Concrete implementations for the abstract template methods in
# HasManyOrdinalChildrenBase for Article
module Article::HasManyOrdinalChildren
  include HasManyOrdinalChildrenBase

  ##
  # Destroys +child+ basic note and shifts the other
  # basic notes of self appropriately
  def destroy_ordinal_child(child:)
    raise ArgumentError unless child_belongs_to_parent?(child:)

    deleted_ordinal_position = child.ordinal_position
    child.destroy!
    shift_basic_notes_down_to_replace_missing_position(missing_position: deleted_ordinal_position)
  end

  def move_ordinal_child_to_new_parent(child:, new_parent:, new_ordinal_position:)
    raise ArgumentError unless child_belongs_to_parent?(child:)

    removed_article_ordinal_position = child.ordinal_position
    child.update(article: new_parent, ordinal_position: new_parent.notes_count)
    new_parent.reposition_ordinal_child(child:, new_ordinal_position:)
    basic_notes.order(:ordinal_position).where("ordinal_position > ?", removed_article_ordinal_position).each do |basic_note|
      basic_note.update!(ordinal_position: basic_note.ordinal_position - 1)
    end
  end

  # rubocop:disable Metrics/AbcSize

  ##
  # Moves +children+ basic notes to +new_parent+ and shifts the other
  # basic notes of self appropriately
  def move_ordinal_children_to_new_parent(children:, new_parent:)
    raise ArgumentError unless new_parent.book == book

    article_ids = children.pluck(:article_id)
    raise ArgumentError unless article_ids.uniq.count == 1 && article_ids.first == id

    children.order(:ordinal_position).each do |basic_note|
      basic_note.update(article: new_parent, ordinal_position: new_parent.notes_count)
    end
    basic_notes.ordered.each_with_index do |basic_note, index|
      basic_note.update(ordinal_position: index)
    end
  end
  # rubocop:enable Metrics/AbcSize

  def expected_ordinal_positions
    (0...notes_count).to_a
  end

  private

  def shift_basic_notes_down_to_replace_missing_position(missing_position:)
    basic_notes.where("ordinal_position > ?", missing_position).order(:ordinal_position).each do |basic_note|
      basic_note.update!(ordinal_position: basic_note.ordinal_position - 1)
    end
  end

  def ordinal_positions
    notes.ordered.pluck(:ordinal_position)
  end

  def child_belongs_to_parent?(child:)
    return false if child.new_record?

    basic_notes.include?(child)
  end

  def ordinally_positioned_children
    notes
  end

  def ordinally_positioned_children_count
    notes.count
  end
end
