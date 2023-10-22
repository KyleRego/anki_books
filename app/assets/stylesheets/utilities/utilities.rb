# frozen_string_literal: true

require_relative "./paddings_writer"

##
# Runs the classes which write the CSS utilities cascade layer rulesets
class Utilities
  def self.generate
    PaddingsWriter.write_to(path: "./paddings_output.css")
  end
end

Utilities.generate
