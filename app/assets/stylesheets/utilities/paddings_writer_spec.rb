# frozen_string_literal: true

require "spec_helper"
require_relative "./paddings_writer"
require_relative "../license_comment"

RSpec.describe PaddingsWriter do
  subject(:call_paddings_writer) do
    described_class.call(number_of_padding_ruleset_groups:)
  end

  let(:number_of_padding_ruleset_groups) { 0 }

  it "includes the license comment" do
    expect(call_paddings_writer).to include(LICENSE_COMMENT)
  end
end
