# frozen_string_literal: true

When "I check the checkbox for the basic note with front {string}" do |string|
  basic_note = BasicNote.find_by(front: string)
  check(basic_note.id)
end
