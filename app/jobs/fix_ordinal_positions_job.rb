# frozen_string_literal: true

##
# Job to fix ordinal positions in case they become incorrect due to a bug
class FixOrdinalPositionsJob < ApplicationJob
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength

  ##
  # Fixes ordinal positions of all the articles' basic notes and books' articles
  def perform
    Book.find_each do |b|
      unless b.correct_children_ordinal_positions?
        b.articles.order(:ordinal_position).each_with_index do |articl, i|
          articl.update!(ordinal_position: i)
        rescue StandardError
          taken_ordinal_positions = b.articles.order(:ordinal_position).reload.pluck(:ordinal_position)
          expected_ordinal_positions = b.expected_ordinal_positions
          missing_ordinal_positions = expected_ordinal_positions - taken_ordinal_positions
          articl.update(ordinal_position: missing_ordinal_positions.first)
        end
      end
    end

    Article.find_each do |a|
      unless a.correct_children_ordinal_positions?
        a.basic_notes.order(:ordinal_position).each_with_index do |bn, i|
          bn.update!(ordinal_position: i)
        rescue StandardError
          taken_ordinal_positions = a.basic_notes.order(:ordinal_position).reload.pluck(:ordinal_position)
          expected_ordinal_positions = a.expected_ordinal_positions
          missing_ordinal_positions = expected_ordinal_positions - taken_ordinal_positions
          bn.update(ordinal_position: missing_ordinal_positions.first)
        end
      end
    end
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
