# frozen_string_literal: true

# :nodoc:
module Book::PathHelpers
  extend ActiveSupport::Concern

  included do
    include Rails.application.routes.url_helpers
  end

  def custom_path
    book_path(self, title: title_slug)
  end

  def custom_manage_path
    book_manage_path(self, title: title_slug)
  end
end
