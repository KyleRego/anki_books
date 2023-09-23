# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# == Schema Information
#
# Table name: articles_concepts
#
#  id         :uuid             not null, primary key
#  concept_id :uuid             not null
#  article_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (concept_id => concepts.id)
#

# frozen_string_literal: true

##
# Join table between articles and concepts
class ArticlesConcept < ApplicationRecord
  belongs_to :article
  belongs_to :concept
end
