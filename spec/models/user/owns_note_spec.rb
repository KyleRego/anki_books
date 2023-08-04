# frozen_string_literal: true

RSpec.describe User, "#owns_note?" do
  subject { user.owns_note?(note:) }

  let(:user) { create(:user) }
  let(:note) do
    article = create(:article, book:)
    create(:basic_note, article:)
  end

  context "when note is to an article of one of the user's books" do
    let(:book) { create(:book, users: [user]) }

    it { is_expected.to be true }
  end

  context "when note is to an article that does not belong to one of the user's books" do
    let(:book) { create(:book, users: []) }

    it { is_expected.to be false }
  end
end
