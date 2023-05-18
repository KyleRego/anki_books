# frozen_string_literal: true

# :nodoc:
module ArticlesHelper
  def on_study_cards?
    request.path.end_with?("study_cards")
  end

  def back_to_article_path(article)
    return root_path if article.system

    article_path(article, title: article.title_slug)
  end
end
