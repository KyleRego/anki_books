# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Concrete implementations for the abstract template methods in
# HasManyOrdinalChildrenBase for Article
module Book::HasManyOrdinalChildren
  include HasManyOrdinalChildrenBase

  def destroy_ordinal_child(child:)
    raise ArgumentError unless child_belongs_to_parent?(child:)

    deleted_ordinal_position = child.ordinal_position

    child.destroy!

    shift_articles_down_to_replace_missing_position(missing_position: deleted_ordinal_position)
  end

  def move_child_to_new_parent(child:, new_parent:, new_ordinal_position:)
    raise ArgumentError unless child_belongs_to_parent?(child:)

    removed_ordinal_position = child.ordinal_position
    child.update(book: new_parent, ordinal_position: new_parent.articles_count)
    new_parent.reposition_child(child:, new_ordinal_position:)
    shift_articles_down_to_replace_missing_position(missing_position: removed_ordinal_position)
  end

  private

  def shift_articles_down_to_replace_missing_position(missing_position:)
    # rubocop:disable Rails/FindEach
    articles.where("ordinal_position > ?", missing_position).each do |article|
      article.update!(ordinal_position: article.ordinal_position - 1)
    end
    # rubocop:enable Rails/FindEach
  end

  def ordinal_positions
    ordered_articles.pluck(:ordinal_position)
  end

  def expected_ordinal_positions
    (0...articles_count).to_a
  end

  def child_belongs_to_parent?(child:)
    return false if child.new_record?

    articles.include?(child)
  end

  def ordinally_positioned_children
    articles
  end

  def ordinally_positioned_children_count
    articles_count
  end
end
