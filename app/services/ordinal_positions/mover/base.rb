# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module OrdinalPositions
  module Mover
    # :nodoc:
    class Base
      def self.perform(new_parent:, child_to_position:, new_ordinal_position:)
        new(new_parent:, child_to_position:, new_ordinal_position:).perform
      end

      def perform
        ActiveRecord::Base.transaction do
          raise "Ordinal position error" unless move_child_to_position_to_new_parent

          shift_old_parent_children

          # For performance in production, skip this check. But allow it to find bugs
          # in development and testing.
          # :nocov:
          raise "Ordinal position error" if !Rails.env.production? && !ordinal_positions_valid?

          # :nocov:
        end

        true
      end

      private

      attr_reader :new_parent, :old_parent, :child_to_position, :new_ordinal_position, :old_ordinal_position

      def initialize(new_parent:, child_to_position:, new_ordinal_position:)
        @new_parent = new_parent
        @child_to_position = child_to_position
        @new_ordinal_position = new_ordinal_position
        @old_parent = old_parent
        @old_ordinal_position = child_to_position.reload.ordinal_position
      end
    end
  end
end
