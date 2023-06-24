# frozen_string_literal: true

RSpec.shared_examples "user is not logged in and needs to be" do
  it "returns a 401 unauthorized response when user is not logged in" do
    subject
    expect(response).to have_http_status(:unauthorized)
  end
end
