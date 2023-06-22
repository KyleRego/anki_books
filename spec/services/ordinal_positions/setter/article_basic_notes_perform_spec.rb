# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations
# rubocop:disable RSpec/ExampleLength
RSpec.describe OrdinalPositions::Setter::ArticleBasicNotes, ".perform" do
  subject(:perform_ordinal_position_change) do
    described_class.perform(parent:, child_to_position:, new_ordinal_position:)
  end

  context "when the child note is given without an initial ordinal position" do
    let(:parent) { create(:article) }
    let(:child_to_position) { build(:basic_note, article: parent, ordinal_position: nil) }
    let(:new_ordinal_position) { 0 }

    it "throws an ArgumentError" do
      expect { perform_ordinal_position_change }.to raise_exception ArgumentError
    end
  end

  context "when the child note is invalid" do
    let(:parent) { create(:article) }
    let(:child_to_position) { build(:basic_note, article: parent, front: "") }
    let(:new_ordinal_position) { 0 }

    it "throws an ArgumentError" do
      expect { perform_ordinal_position_change }.to raise_exception ArgumentError
    end
  end

  context "when parent is an article with no notes and child is unpersisted basic note" do
    let(:parent) { create(:article) }
    let(:child_to_position) { build(:basic_note, article: parent) }

    context "when new ordinal position is not an integer" do
      let(:new_ordinal_position) { "a" }

      it "throws an ArgumentError" do
        expect { perform_ordinal_position_change }.to raise_exception ArgumentError
      end
    end

    context "when new ordinal position is -1" do
      let(:new_ordinal_position) { -1 }

      it "returns false" do
        expect(perform_ordinal_position_change).to be false
      end
    end

    context "when new ordinal position is 1" do
      let(:new_ordinal_position) { 1 }

      it "returns false" do
        expect(perform_ordinal_position_change).to be false
      end
    end

    context "when new ordinal position is 0" do
      let(:new_ordinal_position) { 0 }

      it "returns true and saves the basic note with ordinal position 0" do
        expect(perform_ordinal_position_change).to be true
        expect(child_to_position.persisted?).to be true
        expect(child_to_position.ordinal_position).to eq 0
      end
    end
  end

  context "when parent is an article with 1 note and child is an unpersisted basic note" do
    let(:parent) { create(:article) }
    let!(:first_basic_note) { create(:basic_note, article: parent) }
    let(:child_to_position) { build(:basic_note, article: parent) }

    context "when new ordinal position is 0" do
      let(:new_ordinal_position) { 0 }

      it "returns true and saves the basic note with position 0 and the other to position 1" do
        expect(perform_ordinal_position_change).to be true
        expect(child_to_position.persisted?).to be true
        expect(child_to_position.reload.ordinal_position).to eq 0
        expect(first_basic_note.reload.ordinal_position).to eq 1
      end
    end

    context "when new ordinal position is 1" do
      let(:new_ordinal_position) { 1 }

      it "returns true and saves the basic note with position 1 and leaves the other at 0" do
        expect(perform_ordinal_position_change).to be true
        expect(child_to_position.persisted?).to be true
        expect(child_to_position.reload.ordinal_position).to eq 1
        expect(first_basic_note.reload.ordinal_position).to eq 0
      end
    end
  end

  context "when parent is an article with 2 notes" do
    let!(:parent) do
      article = create(:article)
      create_list(:basic_note, 2, article:)
      article
    end

    context "when the note at position 0 is moved to position 1" do
      let!(:child_to_position) { parent.basic_notes.find_by(ordinal_position: 0) }
      let!(:other_note) { parent.basic_notes.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 1 }

      it "returns true and repositions the notes" do
        expect(perform_ordinal_position_change).to be true
        expect(child_to_position.reload.ordinal_position).to eq 1
        expect(other_note.reload.ordinal_position).to eq 0
      end
    end

    context "when the note at position 1 is moved to position 0" do
      let!(:child_to_position) { parent.basic_notes.find_by(ordinal_position: 1) }
      let!(:other_note) { parent.basic_notes.find_by(ordinal_position: 0) }
      let(:new_ordinal_position) { 0 }

      it "returns true and repositions the notes" do
        expect(perform_ordinal_position_change).to be true
        expect(child_to_position.reload.ordinal_position).to eq 0
        expect(other_note.reload.ordinal_position).to eq 1
      end
    end

    context "when the new ordinal position is 2" do
      let!(:child_to_position) { parent.basic_notes.find_by(ordinal_position: 0) }
      let!(:other_note) { parent.basic_notes.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 2 }

      it "returns false and does not reposition the notes" do
        expect(perform_ordinal_position_change).to be false
        expect(child_to_position.reload.ordinal_position).to eq 0
        expect(other_note.reload.ordinal_position).to eq 1
      end
    end

    context "when the new ordinal position is -1" do
      let!(:child_to_position) { parent.basic_notes.find_by(ordinal_position: 0) }
      let!(:other_note) { parent.basic_notes.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { -1 }

      it "returns false and does not reposition the notes" do
        expect(perform_ordinal_position_change).to be false
        expect(child_to_position.reload.ordinal_position).to eq 0
        expect(other_note.reload.ordinal_position).to eq 1
      end
    end

    context "when the new ordinal position is the same" do
      let!(:child_to_position) { parent.basic_notes.find_by(ordinal_position: 0) }
      let!(:other_note) { parent.basic_notes.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 0 }

      it "returns true and leaves the notes with the same positions" do
        expect(perform_ordinal_position_change).to be true
        expect(child_to_position.reload.ordinal_position).to eq 0
        expect(other_note.reload.ordinal_position).to eq 1
      end
    end

    context "when the note to position is an unpersisted note" do
      let!(:note_starting_at_zero) { parent.basic_notes.find_by(ordinal_position: 0) }
      let!(:note_starting_at_one) { parent.basic_notes.find_by(ordinal_position: 1) }
      let(:child_to_position) { build(:basic_note, article: parent) }

      context "when the new ordinal position is 0" do
        let(:new_ordinal_position) { 0 }

        it "returns true, puts the note at position 0, and shifts up the other two notes" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 0
          expect(note_starting_at_zero.reload.ordinal_position).to eq 1
          expect(note_starting_at_one.reload.ordinal_position).to eq 2
        end
      end

      context "when the new ordinal position is 1" do
        let(:new_ordinal_position) { 1 }

        it "returns true, puts the note at position 1, and shifts up one note" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 1
          expect(note_starting_at_zero.reload.ordinal_position).to eq 0
          expect(note_starting_at_one.reload.ordinal_position).to eq 2
        end
      end

      context "when the new ordinal position is 2" do
        let(:new_ordinal_position) { 2 }

        it "returns true, puts the note at position 0, and leaves the other two notes" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 2
          expect(note_starting_at_zero.reload.ordinal_position).to eq 0
          expect(note_starting_at_one.reload.ordinal_position).to eq 1
        end
      end

      context "when the new ordinal position is -1" do
        let(:new_ordinal_position) { -1 }

        it "returns false and does not persist the note" do
          expect(perform_ordinal_position_change).to be false
          expect(child_to_position.persisted?).to be false
          expect(note_starting_at_zero.reload.ordinal_position).to eq 0
          expect(note_starting_at_one.reload.ordinal_position).to eq 1
        end
      end

      context "when the new ordinal position is 3" do
        let(:new_ordinal_position) { 3 }

        it "returns false and does not persist the note" do
          expect(perform_ordinal_position_change).to be false
          expect(child_to_position.persisted?).to be false
          expect(note_starting_at_zero.reload.ordinal_position).to eq 0
          expect(note_starting_at_one.reload.ordinal_position).to eq 1
        end
      end
    end
  end

  context "when parent is an article with 3 notes" do
    let!(:parent) do
      article = create(:article)
      create_list(:basic_note, 3, article:)
      article
    end

    let!(:note_starting_at_zero) { parent.basic_notes.find_by(ordinal_position: 0) }
    let!(:note_starting_at_one) { parent.basic_notes.find_by(ordinal_position: 1) }
    let!(:note_starting_at_two) { parent.basic_notes.find_by(ordinal_position: 2) }

    context "when the note to position was at position 0" do
      let(:child_to_position) { note_starting_at_zero }

      context "when the new position is 2" do
        let(:new_ordinal_position) { 2 }

        it "returns true and moves the note to position 2, shifting the others down" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 2
          expect(note_starting_at_one.reload.ordinal_position).to eq 0
          expect(note_starting_at_two.reload.ordinal_position).to eq 1
        end
      end

      context "when the new position is 1" do
        let(:new_ordinal_position) { 1 }

        it "returns true and moves the note to position 2, shifting one note down" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 1
          expect(note_starting_at_one.reload.ordinal_position).to eq 0
          expect(note_starting_at_two.reload.ordinal_position).to eq 2
        end
      end

      context "when the new position is 0" do
        let(:new_ordinal_position) { 0 }

        it "returns true and does not move the notes" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 0
          expect(note_starting_at_one.reload.ordinal_position).to eq 1
          expect(note_starting_at_two.reload.ordinal_position).to eq 2
        end
      end
    end

    context "when the note to position was at position 1" do
      let(:child_to_position) { note_starting_at_one }

      context "when the new position is 2" do
        let(:new_ordinal_position) { 2 }

        it "returns true and moves the note to position 2, one shifting one down" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 2
          expect(note_starting_at_zero.reload.ordinal_position).to eq 0
          expect(note_starting_at_two.reload.ordinal_position).to eq 1
        end
      end

      context "when the new position is 1" do
        let(:new_ordinal_position) { 1 }

        it "returns true and does not move the notes" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 1
          expect(note_starting_at_zero.reload.ordinal_position).to eq 0
          expect(note_starting_at_two.reload.ordinal_position).to eq 2
        end
      end

      context "when the new position is 0" do
        let(:new_ordinal_position) { 0 }

        it "returns true and moves one note up" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 0
          expect(note_starting_at_zero.reload.ordinal_position).to eq 1
          expect(note_starting_at_two.reload.ordinal_position).to eq 2
        end
      end
    end

    context "when the note to position was at position 2" do
      let(:child_to_position) { note_starting_at_two }

      context "when the new position is 2" do
        let(:new_ordinal_position) { 2 }

        it "returns true and moves one note up" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 2
          expect(note_starting_at_zero.reload.ordinal_position).to eq 0
          expect(note_starting_at_one.reload.ordinal_position).to eq 1
        end
      end

      context "when the new position is 1" do
        let(:new_ordinal_position) { 1 }

        it "returns true and moves the note to position 1, shifting one note up" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 1
          expect(note_starting_at_zero.reload.ordinal_position).to eq 0
          expect(note_starting_at_one.reload.ordinal_position).to eq 2
        end
      end

      context "when the new position is 0" do
        let(:new_ordinal_position) { 0 }

        it "returns true and positions the note, shifting the other two up" do
          expect(perform_ordinal_position_change).to be true
          expect(child_to_position.reload.ordinal_position).to eq 0
          expect(note_starting_at_zero.reload.ordinal_position).to eq 1
          expect(note_starting_at_one.reload.ordinal_position).to eq 2
        end
      end
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  context "when parent is an article with 7 notes" do
    let!(:parent) do
      article = create(:article)
      create_list(:basic_note, 7, article:)
      article
    end

    let!(:note_starting_at_zero) { parent.basic_notes.find_by(ordinal_position: 0) }
    let!(:note_starting_at_one) { parent.basic_notes.find_by(ordinal_position: 1) }
    let!(:note_starting_at_two) { parent.basic_notes.find_by(ordinal_position: 2) }
    let!(:note_starting_at_three) { parent.basic_notes.find_by(ordinal_position: 3) }
    let!(:note_starting_at_four) { parent.basic_notes.find_by(ordinal_position: 4) }
    let!(:note_starting_at_five) { parent.basic_notes.find_by(ordinal_position: 5) }
    let!(:note_starting_at_six) { parent.basic_notes.find_by(ordinal_position: 6) }

    it "shifts the note at 0 to 6 correctly" do
      described_class.perform(parent:, child_to_position: note_starting_at_zero, new_ordinal_position: 6)
      expect(note_starting_at_zero.reload.ordinal_position).to eq 6
      expect(note_starting_at_one.reload.ordinal_position).to eq 0
      expect(note_starting_at_two.reload.ordinal_position).to eq 1
      expect(note_starting_at_three.reload.ordinal_position).to eq 2
      expect(note_starting_at_four.reload.ordinal_position).to eq 3
      expect(note_starting_at_five.reload.ordinal_position).to eq 4
      expect(note_starting_at_six.reload.ordinal_position).to eq 5
    end

    it "shifts the note at 6 to 0 correctly" do
      described_class.perform(parent:, child_to_position: note_starting_at_six, new_ordinal_position: 0)
      expect(note_starting_at_zero.reload.ordinal_position).to eq 1
      expect(note_starting_at_one.reload.ordinal_position).to eq 2
      expect(note_starting_at_two.reload.ordinal_position).to eq 3
      expect(note_starting_at_three.reload.ordinal_position).to eq 4
      expect(note_starting_at_four.reload.ordinal_position).to eq 5
      expect(note_starting_at_five.reload.ordinal_position).to eq 6
      expect(note_starting_at_six.reload.ordinal_position).to eq 0
    end

    it "shifts the note at 2 to 5 correctly" do
      described_class.perform(parent:, child_to_position: note_starting_at_two, new_ordinal_position: 5)
      expect(note_starting_at_zero.reload.ordinal_position).to eq 0
      expect(note_starting_at_one.reload.ordinal_position).to eq 1
      expect(note_starting_at_two.reload.ordinal_position).to eq 5
      expect(note_starting_at_three.reload.ordinal_position).to eq 2
      expect(note_starting_at_four.reload.ordinal_position).to eq 3
      expect(note_starting_at_five.reload.ordinal_position).to eq 4
      expect(note_starting_at_six.reload.ordinal_position).to eq 6
    end

    it "shifts the note at 6 to 1 correctly" do
      described_class.perform(parent:, child_to_position: note_starting_at_six, new_ordinal_position: 1)
      expect(note_starting_at_zero.reload.ordinal_position).to eq 0
      expect(note_starting_at_one.reload.ordinal_position).to eq 2
      expect(note_starting_at_two.reload.ordinal_position).to eq 3
      expect(note_starting_at_three.reload.ordinal_position).to eq 4
      expect(note_starting_at_four.reload.ordinal_position).to eq 5
      expect(note_starting_at_five.reload.ordinal_position).to eq 6
      expect(note_starting_at_six.reload.ordinal_position).to eq 1
    end

    it "shifts the note at 3 to 4 correctly" do
      described_class.perform(parent:, child_to_position: note_starting_at_three, new_ordinal_position: 4)
      expect(note_starting_at_zero.reload.ordinal_position).to eq 0
      expect(note_starting_at_one.reload.ordinal_position).to eq 1
      expect(note_starting_at_two.reload.ordinal_position).to eq 2
      expect(note_starting_at_three.reload.ordinal_position).to eq 4
      expect(note_starting_at_four.reload.ordinal_position).to eq 3
      expect(note_starting_at_five.reload.ordinal_position).to eq 5
      expect(note_starting_at_six.reload.ordinal_position).to eq 6
    end

    it "shifts the note at 4 to 3 correctly" do
      described_class.perform(parent:, child_to_position: note_starting_at_four, new_ordinal_position: 3)
      expect(note_starting_at_zero.reload.ordinal_position).to eq 0
      expect(note_starting_at_one.reload.ordinal_position).to eq 1
      expect(note_starting_at_two.reload.ordinal_position).to eq 2
      expect(note_starting_at_three.reload.ordinal_position).to eq 4
      expect(note_starting_at_four.reload.ordinal_position).to eq 3
      expect(note_starting_at_five.reload.ordinal_position).to eq 5
      expect(note_starting_at_six.reload.ordinal_position).to eq 6
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
# rubocop:enable RSpec/MultipleExpectations
# rubocop:enable RSpec/ExampleLength
