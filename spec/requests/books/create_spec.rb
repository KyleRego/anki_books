# frozen_string_literal: true

RSpec.describe "Books" do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe "POST /books" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      # rubocop:disable RSpec/MultipleExpectations
      it "creates a new book" do
        expect { post books_path, params: { book: { title: "the title" } } }.to change(Book, :count).by 1
        expect(user.books.last.title).to eq "the title"
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context "when not logged in" do
      it "does not create a new book" do
        expect { post books_path, params: { book: { title: "the title" } } }.not_to change(Book, :count)
      end
    end
  end
end