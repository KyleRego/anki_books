# frozen_string_literal: true

# :nodoc:
module ArticlesHelper
  def on_study_cards?
    request.path.end_with?("study_cards")
  end
end
