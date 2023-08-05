# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/missing_turboframe_header_forbidden"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "POST /articles/:article_id/basic_notes", "#create" do
  subject(:post_basic_notes_create) do
    post article_basic_notes_path(article,
                                  format: :turbo_stream,
                                  basic_note: { front:, back: },
                                  ordinal_position:),
         headers: { "Turbo-Frame": turbo_id }
  end

  include BasicNotesHelper

  let(:article) { create(:article) }
  let(:front) { "Front " }
  let(:back) { "Back" }
  let(:ordinal_position) { 0 }
  let(:turbo_id) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"

    context "when Turbo-Frame header is the first new basic note turbo id" do
      let(:turbo_id) { first_new_basic_note_turbo_id }

      it "creates a basic note with ordinal position 0" do
        expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.count).to eq 1
        expect(article.basic_notes.first.ordinal_position).to eq 0
      end

      context "when the ordinal position param is negative" do
        let(:ordinal_position) { -1 }
        let(:turbo_id) { article.basic_notes.first.new_sibling_note_turbo_id }

        before { create(:basic_note, article:) }

        it "does not create a basic note" do
          expect { post_basic_notes_create }.not_to change(BasicNote, :count)
        end
      end

      context "when the ordinal position param is greater than how many basic notes the article has" do
        let(:ordinal_position) { 2 }
        let(:turbo_id) { article.basic_notes.first.new_sibling_note_turbo_id }

        before { create(:basic_note, article:) }

        it "does not create a basic note" do
          expect { post_basic_notes_create }.not_to change(BasicNote, :count)
        end
      end
    end

    context "when article has 1 note and the ordinal position param is 1" do
      let(:ordinal_position) { 1 }
      let(:turbo_id) { article.basic_notes.first.new_sibling_note_turbo_id }

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
      let(:turbo_id) { article.basic_notes.find_by(ordinal_position: 1).new_sibling_note_turbo_id }

      before { create_list(:basic_note, 2, article:) }

      it "creates a basic note at ordinal position 1 and shifts the middle note" do
        expect { post_basic_notes_create }.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.order(:created_at).last.ordinal_position).to eq 1
      end
    end
  end
end
