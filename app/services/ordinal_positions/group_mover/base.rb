# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module OrdinalPositions
  module GroupMover
    ##
    # General logic of moving a group of ordinally positioned children
    # to a new parent to a new ordinal position keeping both
    # parents ordinal position children consistent
    class Base
      def self.perform(new_parent:, old_parent:, children_to_position:)
        new(new_parent:, old_parent:, children_to_position:).perform
      end

      def perform
        raise ArgumentError unless valid_move_target?

        return true unless children_to_position.any?

        raise "All children to position must belong to old parent" unless all_children_to_position_belong_to_old_article?

        ActiveRecord::Base.transaction do
          move_children_to_position_to_new_parent
          shift_old_parent_children
          raise "Ordinal position error" unless ordinal_positions_valid?
        end

        true
      end

      private

      attr_reader :new_parent, :old_parent, :children_to_position

      def initialize(new_parent:, old_parent:, children_to_position:)
        @new_parent = new_parent
        @children_to_position = children_to_position
        @old_parent = old_parent
      end
    end
  end
end
