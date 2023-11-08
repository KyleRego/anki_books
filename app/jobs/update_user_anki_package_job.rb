# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Update the Anki deck package file attached to the user
# through Active Storage
class UpdateUserAnkiPackageJob < ApplicationJob
  queue_as :default

  def perform(user:)
    @user = user
    package_path = AnkiPackages::CreateUserAnkiPackageJob.perform_now(user:)
    user.update_anki_package(package_path:, name_for_attachment:)
    DeleteAnkiPackageJob.set(wait: 3.minutes).perform_later(anki_deck_file_path: package_path)
  end

  private

  attr_reader :user

  def name_for_attachment
    "#{user.username}_anki_package.apkg"
  end
end
