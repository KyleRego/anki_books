# frozen_string_literal: true

RSpec.describe "GET /", "#show" do
  before { create(:article, system: true) }

  it "shows the homepage" do
    get root_path
    expect(response).to be_successful
  end
end
