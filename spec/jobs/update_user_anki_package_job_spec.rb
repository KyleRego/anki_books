# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe UpdateUserAnkiPackageJob do
  subject(:update_user_anki_deck_job) { described_class.perform_now(user:) }

  let(:user) { create(:user) }
  let(:updated_package_fixture_path) { "spec/fixtures/anki_package_2.apkg" }

  before do
    allow(AnkiPackages::CreateUserAnkiPackageJob).to receive(:perform_now).with(user:).and_return(updated_package_fixture_path)
    mock_job = class_double(DeleteAnkiPackageJob)
    # TODO: A test here where the delete job is not mocked
    allow(DeleteAnkiPackageJob).to receive(:set).with(wait: 3.minutes).and_return(mock_job)
    allow(mock_job).to receive(:perform_later).with(anki_deck_file_path: updated_package_fixture_path)
  end

  it "attaches the anki package to the user and schedules the job to delete the temporary file" do
    expect(user.anki_package.attached?).to be false
    update_user_anki_deck_job
    expect(user.reload.anki_package.attached?).to be true
    expect(user.anki_package.attachment.filename.to_s).to include(user.username)
  end

  context "when the user has an anki package already" do
    before do
      user.anki_package.attach(io: File.open("spec/fixtures/anki_package.apkg"), filename: "test.apkg")
    end

    it "replaces the existing anki package attachment with a new one" do
      expect(user.anki_package.attached?).to be true
      update_user_anki_deck_job
      expect(user.reload.anki_package.attached?).to be true
      expect(user.anki_package.attachment.filename.to_s).to include(user.username)
    end
  end
end
