# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "POST /articles/:article_id/basic_notes", "#create" do
  subject(:post_basic_notes_create) do
    post article_basic_notes_path(article,
                                  format: :turbo_stream,
                                  basic_note: { front:, back: },
                                  ordinal_position:),
         headers: { "Turbo-Frame": turbo_id }
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:front) { "Front " }
  let(:back) { "Back" }
  let(:ordinal_position) { 0 }
  let(:turbo_id) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"

    context "when Turbo-Frame header is the first new basic note turbo id" do
      let(:turbo_id) { Note.ordinal_position_zero_turbo_dom_id }

      it "creates a basic note with ordinal position 0" do
        expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.count).to eq 1
        expect(article.basic_notes.first.ordinal_position).to eq 0
      end

      context "when the ordinal position param is negative" do
        let(:ordinal_position) { -1 }
        let(:turbo_id) { article.basic_notes.first.new_next_note_sibling_after_note_turbo_id }

        before { create(:basic_note, article:) }

        it "creates a basic note and puts it at the end of the article" do
          expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
          expect(article.correct_children_ordinal_positions?).to be true
        end
      end

      context "when the article has cloze notes and basic notes" do
        before do
          create(:basic_note, article:, ordinal_position: 0)
          create(:cloze_note, article:, ordinal_position: 1)
          create(:basic_note, article:, ordinal_position: 2)
          create(:cloze_note, article:, ordinal_position: 3)
        end

        context "when basic note is added at the end" do
          let(:ordinal_position) { 4 }
          let(:turbo_id) { "todo-put turbo id here after refactor front end" }

          it "creates a basic note at the end" do
            expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
            expect(article.correct_children_ordinal_positions?).to be true
          end
        end

        context "when basic note is added in the middle" do
          let(:ordinal_position) { 1 }
          let(:turbo_id) { "todo" }

          it "creates a basic note at the ordinal position given by the param" do
            expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
            expect(article.correct_children_ordinal_positions?).to be true
          end
        end
      end

      context "when the ordinal position param is greater than how many basic notes the article has" do
        let(:ordinal_position) { 2 }
        let(:turbo_id) { article.basic_notes.first.new_next_note_sibling_after_note_turbo_id }

        before { create(:basic_note, article:) }

        it "creates a basic note and puts it at the end of the article" do
          expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
          expect(article.correct_children_ordinal_positions?).to be true
        end
      end
    end

    context "when article has 1 note and the ordinal position param is 1" do
      let(:ordinal_position) { 1 }
      let(:turbo_id) { article.basic_notes.first.new_next_note_sibling_after_note_turbo_id }

      before { create(:basic_note, article:) }

      it "creates a basic note with ordinal position 1" do
        expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.count).to eq 2
        expect(article.basic_notes.order(:created_at).last.ordinal_position).to eq 1
      end

      context "when front and back params are empty" do
        let(:front) { nil }
        let(:back) { nil }

        it "does not create a basic note" do
          expect { post_basic_notes_create }.not_to change(BasicNote, :count)
        end
      end
    end

    context "when article has 2 notes and the ordinal position param is 1" do
      let(:ordinal_position) { 1 }
      let(:turbo_id) { article.basic_notes.find_by(ordinal_position: 1).new_next_note_sibling_after_note_turbo_id }

      before { create_list(:basic_note, 2, article:) }

      it "creates a basic note at ordinal position 1 and shifts the middle note" do
        expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.order(:created_at).last.ordinal_position).to eq 1
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end
  end
end
