# frozen_string_literal: true

RSpec.describe User, "#can_access_book?" do
  subject { user.can_access_book?(book:) }

  let(:user) { create(:user) }

  context "when the book is one of the user's books" do
    let(:book) { create(:book, users: [user]) }

    it { is_expected.to be true }
  end

  context "when the book is not one of the user's books" do
    let(:book) { create(:book, users: []) }

    it { is_expected.to be false }
  end
end
