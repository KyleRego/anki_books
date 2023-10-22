# frozen_string_literal: true

require_relative "./paddings_writer"
require_relative "../license_comment"

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

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
    result += "\n"
    number_of_padding_ruleset_groups.times do |i|
      rems = "#{0.25 * (i + 1)}rem"
      result += "  .p-1 {\n"
      result += "    padding: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .px-1 {\n"
      result += "    padding-left: #{rems};\n"
      result += "    padding-right: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .py-1 {\n"
      result += "    padding-top: #{rems};\n"
      result += "    padding-bottom: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .pl-1 {\n"
      result += "    padding-left: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .pr-1 {\n"
      result += "    padding-right: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .pt-1 {\n"
      result += "    padding-top: #{rems};\n"
      result += "  }\n"
      result += "\n"
      result += "  .pb-1 {\n"
      result += "    padding-bottom: #{rems};\n"
      result += "  }\n"
      result += "}\n"
    end
    result
  end

  def self.write_to(path:)
    File.write(path, call(number_of_padding_ruleset_groups: 1))
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
