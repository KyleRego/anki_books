# frozen_string_literal: true

# :nodoc:
module ArticlesHelper
  def on_study_cards?
    request.path.end_with?("study_cards")
  end

  def show_study_cards_link?(article)
    return false unless request.path.match?(%r{^/articles/[^/]+/[^/]+$}) || request.path == "/"

    return false if article.notes_count.zero?

    true
  end

  def back_to_article_path(article)
    return root_path if article.system

    article_path(article, title: article.title_slug)
  end
end
