# frozen_string_literal: true

RSpec.shared_examples "user is not logged in and needs to be" do
  it "redirects to the login page when user is not logged in" do
    subject
    expect(response).to have_http_status(:found)
  end
end
