# frozen_string_literal: true

require_relative "./paddings_writer"
require_relative "../license_comment"
# rubocop:disable Lint/UnusedMethodArgument
##
# PaddingsWriter is a static metaprogramming class to generate
# the padding CSS file _paddings.css
class PaddingsWriter
  ##
  # Returns a string
  def self.call(number_of_padding_ruleset_groups:)
    result = ""
    result += LICENSE_COMMENT
    result
  end
end
# rubocop:enable Lint/UnusedMethodArgument
