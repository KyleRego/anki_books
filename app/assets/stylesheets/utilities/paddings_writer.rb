# /* Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego */

# frozen_string_literal: true

require_relative "./paddings_writer"
require_relative "../license_comment"

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/BlockLength

NOTABLE_PADDINGS = <<-NOTABLE_PADDINGS
  .p-auto {
    margin: auto;
  }

  .px-auto {
    margin-left: auto;
    margin-right: auto;
  }
NOTABLE_PADDINGS

##
# PaddingsWriter is a static metaprogramming class to generate
# the padding CSS file _paddings.css
class PaddingsWriter
  ##
  # Returns a string
  def self.call(number_of_padding_ruleset_groups:)
    result = ""
    result += LICENSE_COMMENT
    result += "\n"
    result += "@layer utilities {"
    result += "\n"
    result += NOTABLE_PADDINGS
    number_of_padding_ruleset_groups.times do |i|
      num = i + 1
      rems = "#{0.25 * num}rem"
      result += "\n  .p-#{num} {\n"
      result += "    padding: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .px-#{num} {\n"
      result += "    padding-left: #{rems};\n"
      result += "    padding-right: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .py-#{num} {\n"
      result += "    padding-top: #{rems};\n"
      result += "    padding-bottom: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .pl-#{num} {\n"
      result += "    padding-left: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .pr-#{num} {\n"
      result += "    padding-right: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .pt-#{num} {\n"
      result += "    padding-top: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .pb-#{num} {\n"
      result += "    padding-bottom: #{rems};\n"
      result += "  }"
      result += "\n"
    end
    result += "}"
    result
  end

  def self.write_to(path:)
    File.write(path, call(number_of_padding_ruleset_groups: 8))
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/BlockLength
