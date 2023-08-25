# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

PARENT_DOMAINS_FORM_SELECTOR = ".change-parent-domains-area"
CHILD_DOMAINS_FORM_SELECTOR = ".change-child-domains-area"

Given "the test user has a domain called {string}" do |book_title|
  create(:domain, title: book_title, user: @test_user)
end

Given "the book {string} belongs to the {string} domain" do |book_title, domain_title|
  book = Book.find_by(title: book_title)
  domain = Domain.find_by(title: domain_title)
  domain.books << book
end

When "I check the child domain checkbox labeled {string}" do |string|
  within(CHILD_DOMAINS_FORM_SELECTOR) { check(string) }
end

When "I uncheck the child domain checkbox labeled {string}" do |string|
  within(CHILD_DOMAINS_FORM_SELECTOR) { uncheck(string) }
end

Then "the child domain checkbox labeled {string} should be checked" do |string|
  within(CHILD_DOMAINS_FORM_SELECTOR) do
    expect(page).to have_field(string, checked: true)
  end
end

Then "the child domain checkbox labeled {string} should not be checked" do |string|
  within(CHILD_DOMAINS_FORM_SELECTOR) do
    expect(page).to have_field(string, checked: false)
  end
end
