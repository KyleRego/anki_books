# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe SessionsHelper do
  let(:user) { create(:user) }

  describe "#current_user" do
    it "returns nil if no user is logged in" do
      expect(helper.current_user).to be_nil
    end

    it "returns the currently logged-in user" do
      session[:user_id] = user.id
      expect(helper.current_user).to eq(user)
    end
  end

  describe "#logged_in?" do
    it "returns false if no user is logged in" do
      expect(helper).not_to be_logged_in
    end

    it "returns true if a user is currently logged in" do
      session[:user_id] = user.id
      expect(helper).to be_logged_in
    end
  end
end
