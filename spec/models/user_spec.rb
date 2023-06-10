# frozen_string_literal: true

require_relative "../support/shared_contexts/user_with_articles_books_and_notes"

require "rails_helper"

RSpec.describe User do
  describe "notes" do
    include_context "when the user has two books, three articles, 5 basic notes per article"

    let(:basic_notes) { BasicNote.all }

    it "returns the basic notes of the user's books' articles" do
      expect(user.notes).to eq basic_notes
    end
  end
end
