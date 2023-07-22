# frozen_string_literal: true

# :nodoc:
module BasicNotesHelper
  def first_new_basic_note_turbo_id
    BasicNote::TurboFrameable::TURBO_FIRST_NEW_BASIC_NOTE_ID
  end

  # rubocop:disable Rails/HelperInstanceVariable
  # TODO: Think about the design here
  def on_study_cards?
    if @article
      current_page?(study_article_cards_path(@article))
    elsif @book
      current_page?(study_book_cards_path(@book))
    end
  end
  # rubocop:enable Rails/HelperInstanceVariable

  def redirected_from_study_cards?
    request.referer&.end_with?("study_cards")
  end
end
