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
