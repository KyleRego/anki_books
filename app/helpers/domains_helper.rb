# frozen_string_literal: true

# :nodoc:
module DomainsHelper
  def show_link_to_my_domains_in_top_nav?
    !current_page?(domains_path)
  end
end
