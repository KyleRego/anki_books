# /* Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego */

# frozen_string_literal: true

require_relative "../license_comment"

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/BlockLength

NOTABLE_MARGINS = <<-NOTABLE_MARGINS
  .m-auto {
    margin: auto;
  }

  .mx-auto {
    margin-left: auto;
    margin-right: auto;
  }
NOTABLE_MARGINS

##
# MarginsWriter is a static metaprogramming class to generate
# the margin CSS file _margins.css
class MarginsWriter
  ##
  # Returns a string
  def self.call(number_of_margin_ruleset_groups:)
    result = ""
    result += LICENSE_COMMENT
    result += "\n"
    result += "@layer utilities {"
    result += "\n"
    result += NOTABLE_MARGINS
    number_of_margin_ruleset_groups.times do |i|
      num = i + 1
      rems = "#{0.25 * num}rem"
      result += "\n  .m-#{num} {\n"
      result += "    margin: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .mx-#{num} {\n"
      result += "    margin-left: #{rems};\n"
      result += "    margin-right: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .my-#{num} {\n"
      result += "    margin-top: #{rems};\n"
      result += "    margin-bottom: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .ml-#{num} {\n"
      result += "    margin-left: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .mr-#{num} {\n"
      result += "    margin-right: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .mt-#{num} {\n"
      result += "    margin-top: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .mb-#{num} {\n"
      result += "    margin-bottom: #{rems};\n"
      result += "  }"
      result += "\n"
    end
    result += "}"
    result
  end

  def self.write_to(path:)
    File.write(path, call(number_of_margin_ruleset_groups: 8))
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/BlockLength
