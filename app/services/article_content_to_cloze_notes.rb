# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Handles updating the cloze deletion notes creating from the long-text article
# according to the user's concepts
class ArticleContentToClozeNotes
  def self.perform(user:, article:)
    new(user:, article:).perform
  end

  def initialize(user:, article:)
    @article_content = get_article_content(article:)
    @user = user
  end

  def perform
    user.concepts.pluck(:name).each do |concept_name|
      # concept_sentence_regex = /(?:\A|\.|\?|!)([^.]*\b#{concept_name}\b[^.]*)(?=\.)/
      # matches = article_content.scan(concept_sentence_regex).flatten.map do |sentence|
      #   "#{sentence.strip}."
      # end
      # puts matches
    end
  end

  private

  attr_reader :article_content, :user

  def get_article_content(article:)
    article.content.to_plain_text
  end
end
