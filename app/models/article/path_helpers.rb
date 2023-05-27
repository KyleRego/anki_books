# frozen_string_literal: true

# :nodoc:
module Article::PathHelpers
  extend ActiveSupport::Concern

  included do
    include Rails.application.routes.url_helpers
  end

  def custom_path
    article_path(self, title: title_slug)
  end

  def custom_edit_path
    edit_article_path(self, title: title_slug)
  end

  def custom_manage_path
    manage_article_path(self, title: title_slug)
  end

  def custom_study_cards_path
    article_study_cards_path(self, title: title_slug)
  end
end
