# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  describe "notes" do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let(:article) { create(:article) }
    let(:basic_notes) { create_list(:basic_note, 10, article:) }

    it "returns the basic notes of the user's books' articles" do
      expect(user.notes).to eq basic_notes
    end
  end
end
