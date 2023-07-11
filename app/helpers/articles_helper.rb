# frozen_string_literal: true

# :nodoc:
module ArticlesHelper
  ARTICLE_PATH_REGEX = %r{^/articles/[^/]+$}

  def back_to_article_path(article)
    return root_path if article.system

    article_path(article)
  end
end
