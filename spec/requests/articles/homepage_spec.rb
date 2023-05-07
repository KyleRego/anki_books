# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }

  before { create(:article, system: true) }

  describe "GET /" do
    it "shows the homepage" do
      get root_path
      expect(response).to be_successful
    end
  end
end
