# frozen_string_literal: true

module OrdinalPositions
  module Validator
    ##
    # Base logic of checking that the ordinal positions of the children
    # in a one-many relationship with ordinal positions is consistent.
    class Base
      def self.perform(parent:)
        new(parent:).valid?
      end

      attr_reader :parent

      def initialize(parent:)
        @parent = parent
      end

      def valid?
        ordinal_positions == expected_ordinal_positions
      end

      private

      # :nocov:
      def ordinal_positions
        raise NotImplementedError
      end

      def expected_ordinal_positions
        raise NotImplementedError
      end
      # :nocov:
    end
  end
end
