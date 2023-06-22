# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations
# rubocop:disable RSpec/ExampleLength
RSpec.describe OrdinalPositions::Setter::BookArticles, ".perform" do
  subject(:perform_ordinal_position_change) do
    described_class.perform(parent:, child_to_position:, new_ordinal_position:)
  end

  context "when the child article is given without an initial ordinal position" do
    let(:parent) { create(:book) }
    let(:child_to_position) { build(:article, book: parent, ordinal_position: nil) }
    let(:new_ordinal_position) { 0 }

    it "throws an ArgumentError" do
      expect { perform_ordinal_position_change }.to raise_exception ArgumentError
    end
  end

  context "when the child article is invalid without a title" do
    let(:parent) { create(:book) }
    let(:child_to_position) { build(:article, book: parent, title: "") }
    let(:new_ordinal_position) { 0 }

    it "throws an ArgumentError" do
      expect { perform_ordinal_position_change }.to raise_exception ArgumentError
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  context "when book has 10 articles" do
    let!(:parent) do
      book = create(:book)
      create_list(:article, 10, book:)
      book
    end

    let!(:article_starting_at_zero) { parent.articles.find_by(ordinal_position: 0) }
    let!(:article_starting_at_one) { parent.articles.find_by(ordinal_position: 1) }
    let!(:article_starting_at_two) { parent.articles.find_by(ordinal_position: 2) }
    let!(:article_starting_at_three) { parent.articles.find_by(ordinal_position: 3) }
    let!(:article_starting_at_four) { parent.articles.find_by(ordinal_position: 4) }
    let!(:article_starting_at_five) { parent.articles.find_by(ordinal_position: 5) }
    let!(:article_starting_at_six) { parent.articles.find_by(ordinal_position: 6) }
    let!(:article_starting_at_seven) { parent.articles.find_by(ordinal_position: 7) }
    let!(:article_starting_at_eight) { parent.articles.find_by(ordinal_position: 8) }
    let!(:article_starting_at_nine) { parent.articles.find_by(ordinal_position: 9) }

    context "when the article at position 6 is moved to 9" do
      let(:child_to_position) { article_starting_at_six }
      let(:new_ordinal_position) { 9 }

      it "shifts the note from 6 to 9 correctly" do
        perform_ordinal_position_change
        expect(child_to_position.reload.ordinal_position).to eq 9
        expect(article_starting_at_seven.reload.ordinal_position).to eq 6
        expect(article_starting_at_eight.reload.ordinal_position).to eq 7
        expect(article_starting_at_nine.reload.ordinal_position).to eq 8
      end
    end

    context "when the article at position 2 is moved to 4" do
      let(:child_to_position) { article_starting_at_two }
      let(:new_ordinal_position) { 4 }

      it "shifts the note from 2 to 4 correctly" do
        perform_ordinal_position_change
        expect(child_to_position.reload.ordinal_position).to eq 4
        expect(article_starting_at_three.reload.ordinal_position).to eq 2
        expect(article_starting_at_four.reload.ordinal_position).to eq 3
      end
    end

    context "when the article at position 9 is moved to 0" do
      let(:child_to_position) { article_starting_at_nine }
      let(:new_ordinal_position) { 0 }

      it "shifts the notes correctly" do
        perform_ordinal_position_change
        expect(child_to_position.reload.ordinal_position).to eq 0
        expect(article_starting_at_zero.reload.ordinal_position).to eq 1
        expect(article_starting_at_one.reload.ordinal_position).to eq 2
        expect(article_starting_at_two.reload.ordinal_position).to eq 3
        expect(article_starting_at_three.reload.ordinal_position).to eq 4
        expect(article_starting_at_four.reload.ordinal_position).to eq 5
        expect(article_starting_at_five.reload.ordinal_position).to eq 6
        expect(article_starting_at_six.reload.ordinal_position).to eq 7
        expect(article_starting_at_seven.reload.ordinal_position).to eq 8
        expect(article_starting_at_eight.reload.ordinal_position).to eq 9
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
# rubocop:enable RSpec/MultipleExpectations
# rubocop:enable RSpec/ExampleLength
