# /* Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego */

# frozen_string_literal: true

require "spec_helper"
require_relative "./paddings_writer"
require_relative "../license_comment"

# rubocop:disable RSpec/ExampleLength

RSpec.describe PaddingsWriter do
  subject(:call_paddings_writer) do
    described_class.call(number_of_padding_ruleset_groups:)
  end

  let(:number_of_padding_ruleset_groups) { 0 }

  it "includes the license comment" do
    expect(call_paddings_writer).to include(LICENSE_COMMENT)
  end

  it "includes the utilities cascade layer" do
    expect(call_paddings_writer).to include "#{LICENSE_COMMENT.last(4)}\n@layer utilities {"
  end

  it "includes the notable padding properties" do
    expected = NOTABLE_PADDINGS
    expect(call_paddings_writer).to include(expected)
  end

  context "when number_of_paddings_ruleset_groups is 1" do
    let(:number_of_padding_ruleset_groups) { 1 }

    it "includes the padding-1 properties that are equal to 0.25rem" do
      expected = <<~HEREDOC.strip
        /* Anki Books, a note-taking app to organize knowledge,
        is licensed under the GNU Affero General Public License, version 3
        Copyright (C) 2023 Kyle Rego */

        @layer utilities {
          .p-auto {
            margin: auto;
          }

          .px-auto {
            margin-left: auto;
            margin-right: auto;
          }

          .p-1 {
            padding: 0.25rem;
          }

          .px-1 {
            padding-left: 0.25rem;
            padding-right: 0.25rem;
          }

          .py-1 {
            padding-top: 0.25rem;
            padding-bottom: 0.25rem;
          }

          .pl-1 {
            padding-left: 0.25rem;
          }

          .pr-1 {
            padding-right: 0.25rem;
          }

          .pt-1 {
            padding-top: 0.25rem;
          }

          .pb-1 {
            padding-bottom: 0.25rem;
          }
        }
      HEREDOC
      expect(call_paddings_writer).to include(expected)
    end
  end

  context "when number_of_paddings_ruleset_groups is 3" do
    let(:number_of_padding_ruleset_groups) { 3 }

    it "includes the padding-1 properties that are equal to 0.25rem" do
      expected = <<~HEREDOC.strip
        /* Anki Books, a note-taking app to organize knowledge,
        is licensed under the GNU Affero General Public License, version 3
        Copyright (C) 2023 Kyle Rego */

        @layer utilities {
          .p-auto {
            margin: auto;
          }

          .px-auto {
            margin-left: auto;
            margin-right: auto;
          }

          .p-1 {
            padding: 0.25rem;
          }

          .px-1 {
            padding-left: 0.25rem;
            padding-right: 0.25rem;
          }

          .py-1 {
            padding-top: 0.25rem;
            padding-bottom: 0.25rem;
          }

          .pl-1 {
            padding-left: 0.25rem;
          }

          .pr-1 {
            padding-right: 0.25rem;
          }

          .pt-1 {
            padding-top: 0.25rem;
          }

          .pb-1 {
            padding-bottom: 0.25rem;
          }

          .p-2 {
            padding: 0.5rem;
          }

          .px-2 {
            padding-left: 0.5rem;
            padding-right: 0.5rem;
          }

          .py-2 {
            padding-top: 0.5rem;
            padding-bottom: 0.5rem;
          }

          .pl-2 {
            padding-left: 0.5rem;
          }

          .pr-2 {
            padding-right: 0.5rem;
          }

          .pt-2 {
            padding-top: 0.5rem;
          }

          .pb-2 {
            padding-bottom: 0.5rem;
          }

          .p-3 {
            padding: 0.75rem;
          }

          .px-3 {
            padding-left: 0.75rem;
            padding-right: 0.75rem;
          }

          .py-3 {
            padding-top: 0.75rem;
            padding-bottom: 0.75rem;
          }

          .pl-3 {
            padding-left: 0.75rem;
          }

          .pr-3 {
            padding-right: 0.75rem;
          }

          .pt-3 {
            padding-top: 0.75rem;
          }

          .pb-3 {
            padding-bottom: 0.75rem;
          }
        }
      HEREDOC
      expect(call_paddings_writer).to include(expected)
    end
  end
end
# rubocop:enable RSpec/ExampleLength
