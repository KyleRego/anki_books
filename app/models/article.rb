# frozen_string_literal: true

# :nodoc:
class Article < ApplicationRecord
  belongs_to :book, optional: true
  has_rich_text :content
  has_many :basic_notes, dependent: :destroy

  validates :title, presence: true

  def notes
    basic_notes.order(:ordinal_position)
  end

  def notes_count
    basic_notes.count
  end

  def current_ordinal_position_range_includes?(note_ordinal_position:)
    return true if note_ordinal_position.zero?

    (note_ordinal_position < notes_count) && note_ordinal_position.positive?
  end

  def valid_ordinal_position_for_new_note?(note_ordinal_position:)
    return true if note_ordinal_position == notes_count

    current_ordinal_position_range_includes?(note_ordinal_position:)
  end

  def move_note_to_new_ordinal_position_and_shift_notes(note:, new_ordinal_position:)
    old_ordinal_position = note.ordinal_position
    return if old_ordinal_position == new_ordinal_position

    note.update!(ordinal_position: notes_count)
    if new_ordinal_position > old_ordinal_position
      shift_notes_down_to_open_position_for_note(old_ordinal_position:, new_ordinal_position:)
    else
      shift_notes_up_to_open_position_for_note(old_ordinal_position:, new_ordinal_position:)
    end
    note.update!(ordinal_position: new_ordinal_position)
  end

  private

  def shift_notes_down_to_open_position_for_note(old_ordinal_position:, new_ordinal_position:)
    basic_notes.where(
      "ordinal_position > ? and ordinal_position <= ?", old_ordinal_position, new_ordinal_position
    )
               .order(:ordinal_position).each do |shift_note|
      shift_note.update!(ordinal_position: shift_note.ordinal_position - 1)
    end
  end

  def shift_notes_up_to_open_position_for_note(old_ordinal_position:, new_ordinal_position:)
    basic_notes.where(
      "ordinal_position < ? and ordinal_position >= ?", old_ordinal_position, new_ordinal_position
    )
               .order(ordinal_position: :desc).each do |shift_note|
      shift_note.update!(ordinal_position: shift_note.ordinal_position + 1)
    end
  end
end
