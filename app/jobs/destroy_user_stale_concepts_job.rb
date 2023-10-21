# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Delete user's concepts that have no cloze notes
class DestroyUserStaleConceptsJob < ApplicationJob
  queue_as :default

  def perform(user:)
    user.concepts.find_each do |concept|
      next if concept.cloze_notes.any?

      concept.destroy
    end
  end
end
