# frozen_string_literal: true

##
# Currently this positions the basic notes ordinal_position to an article,
# by shifting the ordinal positions of the other notes as necessary,
# but the interface is designed to be general so the functionality can be
# extended to position articles in a book in the future for example.
class OrdinalPositionSaver
  def self.perform(parent:, child_to_position:, new_ordinal_position:)
    new(parent:, child_to_position:, new_ordinal_position:).perform
  end

  attr_reader :parent, :child_to_position, :new_ordinal_position, :old_ordinal_position

  def initialize(parent:, child_to_position:, new_ordinal_position:)
    @parent = parent
    @child_to_position = child_to_position
    @new_ordinal_position = new_ordinal_position
    @old_ordinal_position = child_to_position.ordinal_position
  end

  def perform
    raise ArgumentError unless new_ordinal_position.instance_of?(Integer)

    raise ArgumentError if child_to_position.invalid?

    return child_to_position.save if new_ordinal_position == old_ordinal_position

    return false unless valid_new_ordinal_position

    move_child_to_position_and_shift_others
  end

  private

  def positioned_children_count
    @positioned_children_count ||= child_to_position.new_record? ? parent.notes_count + 1 : parent.notes_count
  end

  def valid_new_ordinal_position
    return true if new_ordinal_position.zero?

    return true if (new_ordinal_position + 1) == positioned_children_count

    (new_ordinal_position < positioned_children_count) && new_ordinal_position.positive?
  end

  def move_child_to_position_and_shift_others
    child_to_position.update!(ordinal_position: positioned_children_count)
    new_ordinal_position > old_ordinal_position ? shift_others_down_to_open_position : shift_others_up_to_open_position
    child_to_position.update!(ordinal_position: new_ordinal_position)
  end

  def shift_others_down_to_open_position
    parent.basic_notes.where(
      "ordinal_position > ? and ordinal_position <= ?", old_ordinal_position, new_ordinal_position
    )
          .order(:ordinal_position).each do |other|
      other.update!(ordinal_position: other.ordinal_position - 1)
    end
  end

  def shift_others_up_to_open_position
    parent.basic_notes.where(
      "ordinal_position < ? and ordinal_position >= ?", old_ordinal_position, new_ordinal_position
    )
          .order(ordinal_position: :desc).each do |other|
      other.update!(ordinal_position: other.ordinal_position + 1)
    end
  end
end
