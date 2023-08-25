# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

require "simplecov"

SimpleCov.add_filter do |source_file|
  source_file.filename.include?("/features/step_definitions/")
end

SimpleCov.start do
  enable_coverage :branch

  add_filter "spec/rails_helper.rb"

  add_group "Models", %r{app/models/.*}
  add_group "Controllers", %r{app/controllers/.*}
  add_group "Jobs", %r{app/jobs/.*}
  add_group "Services", %r{app/services/.*}
end
