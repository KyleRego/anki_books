# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

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
end
