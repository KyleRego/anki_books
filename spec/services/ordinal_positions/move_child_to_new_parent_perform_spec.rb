# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe OrdinalPositions::MoveChildToNewParent, ".perform" do
  subject(:perform_move_to_new_parent) do
    described_class.perform(new_parent:, child_to_position:, new_ordinal_position:)
  end

  context "when parent and child is not a valid class combination" do
    let(:new_parent) { create(:article) }
    let(:child_to_position) { create(:article) }
    let(:new_ordinal_position) { 0 }

    it "raises an error" do
      expect { perform_move_to_new_parent }.to raise_error(RuntimeError)
    end
  end

  context "when moving from a book with one article to a book with no articles" do
    let(:new_parent) { create(:book) }
    let(:child_to_position) { create(:article) }

    context "when the new position is 0" do
      let(:new_ordinal_position) { 0 }

      it "moves the article and returns true" do
        expect(perform_move_to_new_parent).to be true
        expect(child_to_position.book).to eq new_parent
        expect(child_to_position.ordinal_position).to eq new_ordinal_position
      end
    end

    context "when the new position is -1" do
      let(:new_ordinal_position) { -1 }

      it "throws an error and does not move the article" do
        expect { perform_move_to_new_parent }.to raise_error "Ordinal position error"
        expect(child_to_position.reload.book).not_to eq new_parent
        expect(child_to_position.reload.ordinal_position).to eq 0
      end
    end

    context "when the new position is 1" do
      let(:new_ordinal_position) { 1 }

      it "does not move the article and returns false" do
        expect { perform_move_to_new_parent }.to raise_error "Ordinal position error"
        expect(child_to_position.reload.book).not_to eq new_parent
        expect(child_to_position.reload.ordinal_position).to eq 0
      end
    end
  end

  context "when moving from a book with one article to a book with one article" do
    let(:new_parent) { create(:book) }
    let!(:new_parent_other_article) { create(:article, book: new_parent) }
    let(:child_to_position) { create(:article) }

    context "when the new position is 0" do
      let(:new_ordinal_position) { 0 }

      it "moves the article, shifting the other article of the target book, and returns true" do
        expect(perform_move_to_new_parent).to be true
        expect(child_to_position.book.reload).to eq new_parent
        expect(new_parent_other_article.reload.ordinal_position).to eq 1
        expect(child_to_position.ordinal_position).to eq new_ordinal_position
      end
    end

    context "when the new position is 1" do
      let(:new_ordinal_position) { 1 }

      it "moves the article to the target book and returns true" do
        expect(perform_move_to_new_parent).to be true
        expect(child_to_position.reload.book).to eq new_parent
        expect(new_parent_other_article.reload.ordinal_position).to eq 0
        expect(child_to_position.reload.ordinal_position).to eq new_ordinal_position
      end
    end
  end

  context "when moving from a book with three articles to a book with three articles" do
    let!(:new_parent) do
      book = create(:book)
      create_list(:article, 3, book:)
      book
    end
    let!(:old_parent) do
      book = create(:book)
      create_list(:article, 3, book:)
      book
    end

    context "when moving the first article from the first book to be the first of the second book" do
      let(:child_to_position) { old_parent.articles.find_by(ordinal_position: 0) }
      let(:new_ordinal_position) { 0 }

      it "moves the article and shifts other articles correctly" do
        expect(perform_move_to_new_parent).to be true
        expect(child_to_position.reload.book).to eq new_parent
        expect(child_to_position.reload.ordinal_position).to eq new_ordinal_position
        expect(old_parent.articles.pluck(:ordinal_position).sort).to eq [0, 1]
        expect(new_parent.articles.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3]
      end
    end

    context "when moving the second article from the first book to be the third of the second book" do
      let(:child_to_position) { old_parent.articles.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 2 }

      it "moves the article and shifts other articles correctly" do
        expect(perform_move_to_new_parent).to be true
        expect(child_to_position.reload.book).to eq new_parent
        expect(child_to_position.reload.ordinal_position).to eq new_ordinal_position
        expect(old_parent.articles.pluck(:ordinal_position).sort).to eq [0, 1]
        expect(new_parent.articles.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3]
      end
    end
  end

  context "when moving from an article to an article with no basic notes" do
    let(:new_parent) { create(:article) }
    let(:child_to_position) { create(:basic_note, article: create(:article)) }

    context "when the new position is 0" do
      let(:new_ordinal_position) { 0 }

      it "moves the article and returns true" do
        expect(perform_move_to_new_parent).to be true
        expect(child_to_position.article).to eq new_parent
        expect(child_to_position.ordinal_position).to eq new_ordinal_position
      end
    end

    context "when the new position is -1" do
      let(:new_ordinal_position) { -1 }

      it "throws an error and does not move the article" do
        expect { perform_move_to_new_parent }.to raise_error "Ordinal position error"
        expect(child_to_position.reload.article).not_to eq new_parent
        expect(child_to_position.reload.ordinal_position).to eq 0
      end
    end

    context "when the new position is 1" do
      let(:new_ordinal_position) { 1 }

      it "does not move the article and returns false" do
        expect { perform_move_to_new_parent }.to raise_error "Ordinal position error"
        expect(child_to_position.reload.article).not_to eq new_parent
        expect(child_to_position.reload.ordinal_position).to eq 0
      end
    end
  end

  context "when moving from an article with three basic notes to an article with three basic notes" do
    let!(:new_parent) do
      article = create(:article)
      create_list(:basic_note, 3, article:)
      article
    end
    let!(:old_parent) do
      article = create(:article)
      create_list(:basic_note, 3, article:)
      article
    end

    context "when moving the first basic note from the first article to be the first of the target article" do
      let(:child_to_position) { old_parent.basic_notes.find_by(ordinal_position: 0) }
      let(:new_ordinal_position) { 0 }

      it "moves the basic note and shifts other basic notes correctly" do
        expect(perform_move_to_new_parent).to be true
        expect(child_to_position.reload.article).to eq new_parent
        expect(child_to_position.reload.ordinal_position).to eq new_ordinal_position
        expect(old_parent.basic_notes.pluck(:ordinal_position).sort).to eq [0, 1]
        expect(new_parent.basic_notes.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3]
      end
    end

    context "when moving the second basic note from the first article to be the third of the target article" do
      let(:child_to_position) { old_parent.basic_notes.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 2 }

      it "moves the basic note and shifts other basic notes correctly" do
        expect(perform_move_to_new_parent).to be true
        expect(child_to_position.reload.article).to eq new_parent
        expect(child_to_position.reload.ordinal_position).to eq new_ordinal_position
        expect(old_parent.basic_notes.pluck(:ordinal_position).sort).to eq [0, 1]
        expect(new_parent.basic_notes.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3]
      end
    end
  end
end
