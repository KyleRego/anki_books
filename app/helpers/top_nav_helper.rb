# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Helper methods for showing and hiding links in the top nav
module TopNavHelper
  def show_link_to_books_in_top_nav?
    !current_page?(books_path)
  end

  def show_link_to_concepts_in_top_nav?
    !current_page?(concepts_path)
  end

  def show_link_to_downloads_in_top_nav?
    !current_page?(downloads_path)
  end
end
