# frozen_string_literal: true

# :nodoc:
module ArticlesHelper
  ARTICLE_PATH_REGEX = %r{^/articles/[^/]+$}

  def on_study_cards?
    request.path.end_with?("study_cards")
  end

  def show_link_to_study_cards_in_top_nav?(article)
    return false unless request.path.match?(ARTICLE_PATH_REGEX) || request.path == "/"

    return false if article.notes_count.zero?

    true
  end

  def back_to_article_path(article)
    return root_path if article.system

    article_path(article)
  end
end
