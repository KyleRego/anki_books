# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.xdescribe Article, "#cloze_sentences" do
  subject(:cloze_sentences) do
    article.cloze_sentences
  end

  let(:book) { create(:book) }
  let(:article) { create(:article, book:, content:) }


end
