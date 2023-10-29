# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Job that updates the users' Anki packages
# TODO: It will need to prioritize users that need
# their package updated and have been waiting the longest.
class UpdateUserAnkiPackagesJob < ApplicationJob
  queue_as :default

  def perform
    @user = User.first
    package_path = AnkiPackages::CreateUserAnkiPackageJob.perform_now(user:)
    user.update_anki_package(package_path:, name_for_attachment:)
    DeleteAnkiPackageJob.set(wait: 3.minutes).perform_later(package_path:)
  end

  private

  attr_reader :user

  def name_for_attachment
    "#{user.username}_anki_package.apkg"
  end
end
