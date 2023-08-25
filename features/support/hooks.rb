# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

Before do
  @system_book = create(:book, title: "System book")
  @system_article = create(:article, title: "Hello World", system: true, book: @system_book)
  @system_article.content = "This is the system article to serve as the homepage."
  @system_article.save

  @test_user_password = "1234abcd1234"
  user = create(:user, password: @test_user_password)
  @test_user = user
end
