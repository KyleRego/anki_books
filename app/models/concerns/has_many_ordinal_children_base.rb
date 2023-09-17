# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

##
# Concern for models that have a has_many association to child records
# that have an ordinal position to the parent; the ordinal position of
# each child must be unique for that parent and in the range 0 to n - 1
# For example, an article with 3 basic notes must have the basic notes
# at ordinal positions 0, 1, and 2
#
# This module should not be used directly because it only has template
# methods
module HasManyOrdinalChildrenBase
  extend ActiveSupport::Concern

  included do
    ##
    # Checks if the children ordinal positions are correct
    def correct_children_ordinal_positions?
      ordinal_positions == expected_ordinal_positions
    end

    def reposition_child(child:, new_ordinal_position:)
      raise ArgumentError unless child_belongs_to_parent?(child:)

      return false unless valid_child_ordinal_position?(new_ordinal_position:)

      return true if new_ordinal_position == child.ordinal_position

      ActiveRecord::Base.transaction do
        shift_other_children_and_move_child_to_new_ordinal_position(child:, new_ordinal_position:)

        # For performance in production, skip this check. But allow it to find bugs
        # in development and testing.
        # :nocov:
        raise "Ordinal position error" if !Rails.env.production? && !correct_children_ordinal_positions?

        # :nocov:
      end

      true
    end

    private

    def valid_child_ordinal_position?(new_ordinal_position:)
      expected_ordinal_positions.include?(new_ordinal_position)
    end

    def shift_other_children_and_move_child_to_new_ordinal_position(child:, new_ordinal_position:)
      old_ordinal_position = child.ordinal_position
      child.update!(ordinal_position: ordinally_positioned_children_count)
      if new_ordinal_position > old_ordinal_position
        shift_others_down_to_open_position(old_ordinal_position:, new_ordinal_position:)
      else
        shift_others_up_to_open_position(old_ordinal_position:, new_ordinal_position:)
      end
      child.update!(ordinal_position: new_ordinal_position)
    end

    def shift_others_down_to_open_position(old_ordinal_position:, new_ordinal_position:)
      ordinally_positioned_children.where(
        "ordinal_position > ? and ordinal_position <= ?", old_ordinal_position, new_ordinal_position
      )
                                   .order(:ordinal_position).each do |other|
        other.update!(ordinal_position: other.ordinal_position - 1)
      end
    end

    def shift_others_up_to_open_position(old_ordinal_position:, new_ordinal_position:)
      ordinally_positioned_children.where(
        "ordinal_position < ? and ordinal_position >= ?", old_ordinal_position, new_ordinal_position
      )
                                   .order(ordinal_position: :desc).each do |other|
        other.update!(ordinal_position: other.ordinal_position + 1)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
