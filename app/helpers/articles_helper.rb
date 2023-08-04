# frozen_string_literal: true

# :nodoc:
module ArticlesHelper
  ARTICLE_PATH_REGEX = %r{^/articles/[^/]+$}

  def back_to_article_path(article)
    return root_path if article.system

    article_path(article)
  end

  def study_article_cards_path_helper(article:)
    return homepage_study_cards_path if article.system

    study_article_cards_path(article)
  end

  def viewing_an_article?(article)
    return false if article.nil?

    current_page?(article_path(article)) || current_page?(root_path)
  end
end
