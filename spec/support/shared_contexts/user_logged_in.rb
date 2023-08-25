# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.shared_context "when the user is logged in" do
  let(:user) { create(:user) }

  before do
    post login_path, params: { session: { email: user.email,
                                          password: TEST_USER_PASSWORD } }
  end
end
