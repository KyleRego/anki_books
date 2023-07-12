# frozen_string_literal: true

module OrdinalPositions
  module Deleter
    # :nodoc:
    class Base
      def self.perform(child_to_delete:)
        new(child_to_delete:).perform
      end

      def perform
        ActiveRecord::Base.transaction do
          @original_ordinal_position = child_to_delete.ordinal_position

          child_to_delete.destroy

          shift_other_ordinal_children

          raise "Ordinal position error" unless ordinal_positions_valid?
        end
      end

      private

      attr_reader :child_to_delete, :original_ordinal_position

      def initialize(child_to_delete:)
        @child_to_delete = child_to_delete
      end
    end
  end
end
