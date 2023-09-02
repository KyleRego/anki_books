# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Helper methods for showing and hiding links in the top nav
module TopNavHelper
  # TODO: Make this link set in the individual views (refactor to remove this method)
  def show_link_to_book_in_top_nav?(book:)
    book&.persisted? && !current_page?(book_articles_path(book)) && !request.path.end_with?("study_cards")
  end

  def show_link_to_my_books_in_top_nav?
    !current_page?(books_path)
  end

  def show_link_to_concepts_in_top_nav?
    !current_page?(concepts_path)
  end

  def show_link_to_domains_in_top_nav?
    !current_page?(domains_path)
  end

  def show_link_to_root_domains_in_top_nav?
    !current_page?(root_domains_path)
  end

  def show_link_to_downloads_in_top_nav?
    !current_page?(downloads_path)
  end
end
