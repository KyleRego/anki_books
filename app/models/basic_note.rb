# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

#
# Represents an Anki basic note (front and back flashcard)
# == Schema Information
#
# Table name: basic_notes
#
#  id               :uuid             not null, primary key
#  front            :text
#  back             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  article_id       :uuid             not null
#  ordinal_position :integer          not null
#  anki_guid        :string           not null
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
class BasicNote < Note
  include AnkiTimestampable

  include BasicNote::AnkiContentable

  include ERB::Util
  include Rails.application.routes.url_helpers
end
