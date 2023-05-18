# frozen_string_literal: true

# :nodoc:
module TitleSluggable
  def title_slug
    title.parameterize
  end
end
