# frozen_string_literal: true

RSpec.describe "POST /domains", "#create" do
  subject(:post_domains_create) { post domains_path, params: { domain: { title: } } }

  let(:title) { "the title" }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "creates a new domain" do
      expect { post_domains_create }.to change(Domain, :count).by 1
      expect(user.domains.last.title).to eq title
    end

    context "when the title parameter is blank" do
      let(:title) { "" }

      it "does not create a new domain and shows a flash alert" do
        expect { post_domains_create }.not_to change(Domain, :count)
        expect(flash[:alert]).not_to be_nil
      end
    end
  end
end
