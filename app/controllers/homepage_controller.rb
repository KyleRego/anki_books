# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Controller for the site homepage and endpoint to
# study the cards of the homepage.
class HomepageController < ApplicationController
  before_action :setup_homepage

  def show
    render "articles/show"
  end

  def study_cards
    render "study_cards/index"
  end

  private

  def setup_homepage
    @article = Article.find_by(system: true)
    @notes = @article.notes.ordered
  end
end
