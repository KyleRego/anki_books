# frozen_string_literal: true

describe "Initial, temp tests of Trix" do
  before { @article = Article.create(title: "Hello world") }
  it "should test some stuff" do
    visit "/articles/a"
  end
end
