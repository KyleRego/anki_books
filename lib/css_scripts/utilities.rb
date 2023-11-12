# /* Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego */

# frozen_string_literal: true

require_relative "./paddings_writer"
require_relative "./margins_writer"

##
# Runs the classes which write the CSS utilities cascade layer rulesets
class Utilities
  def self.generate
    PaddingsWriter.write_to(path: "./paddings_output.css")
    MarginsWriter.write_to(path: "./margins_output.css")
  end
end

Utilities.generate
