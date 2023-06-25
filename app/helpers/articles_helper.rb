# frozen_string_literal: true

# :nodoc:
module ArticlesHelper
  ARTICLE_PATH_REGEX = %r{^/articles/[^/]+$}

  def on_study_cards?
    request.path.end_with?("study_cards")
  end

  def back_to_article_path(article)
    return root_path if article.system

    article_path(article)
  end
end
