# frozen_string_literal: true

# :nodoc:
module BookGroupsHelper
  def show_link_to_my_book_groups_in_top_nav?
    !current_page?(book_groups_path)
  end
end
