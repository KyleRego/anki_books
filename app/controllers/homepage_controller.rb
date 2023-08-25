# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Controller for the site homepage and endpoint to
# study the cards of the homepage.
# (These are the pages accessible without being logged in.)
class HomepageController < ApplicationController
  before_action :setup_homepage

  def show; end

  def study_cards; end

  private

  def setup_homepage
    # TODO: Probably move the system boolean to books, possibly calling
    # it homepage and having the homepage be a book once the larger book
    # view is completed.
    @article = Article.find_by(system: true)
    @basic_notes = @article.ordered_notes
  end
end
