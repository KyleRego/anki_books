# frozen_string_literal: true

module OrdinalPositionSetter
  ##
  # General logic of managing changing the ordinal position in a one-to-many
  # association where the objects on the many side have an ordinal position;
  # it is like a template method pattern where the child classes implement
  # some of the functionality specific to that association.
  class Base
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

      shift_others_and_move_to_position
      true
    end

    private

    # :nocov:
    def ordinal_position_children_count
      raise NotImplementedError
    end

    def other_ordinal_position_children
      raise NotImplementedError
    end
    # :nocov:

    def valid_new_ordinal_position
      return true if new_ordinal_position.zero?

      return true if (new_ordinal_position + 1) == ordinal_position_children_count

      (new_ordinal_position < ordinal_position_children_count) && new_ordinal_position.positive?
    end

    def shift_others_and_move_to_position
      child_to_position.update!(ordinal_position: ordinal_position_children_count)
      new_ordinal_position > old_ordinal_position ? shift_others_down_to_open_position : shift_others_up_to_open_position
      child_to_position.update!(ordinal_position: new_ordinal_position)
    end

    def shift_others_down_to_open_position
      other_ordinal_position_children.where(
        "ordinal_position > ? and ordinal_position <= ?", old_ordinal_position, new_ordinal_position
      )
                                     .order(:ordinal_position).each do |other|
        other.update!(ordinal_position: other.ordinal_position - 1)
      end
    end

    def shift_others_up_to_open_position
      other_ordinal_position_children.where(
        "ordinal_position < ? and ordinal_position >= ?", old_ordinal_position, new_ordinal_position
      )
                                     .order(ordinal_position: :desc).each do |other|
        other.update!(ordinal_position: other.ordinal_position + 1)
      end
    end
  end
end
