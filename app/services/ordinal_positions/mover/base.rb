# frozen_string_literal: true

module OrdinalPositions
  module Mover
    ##
    # General logic of moving an ordinally positioned child
    # to a new parent to a new ordinal position keeping both
    # parents ordinal position children consistent
    class Base
      def self.perform(new_parent:, child_to_position:, new_ordinal_position:)
        new(new_parent:, child_to_position:, new_ordinal_position:).perform
      end

      def perform
        ActiveRecord::Base.transaction do
          raise "Ordinal position error" unless move_child_to_position_to_new_parent

          shift_old_parent_children

          raise "Ordinal position error" unless ordinal_positions_valid?
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
        @old_ordinal_position = child_to_position.ordinal_position
      end
    end
  end
end
