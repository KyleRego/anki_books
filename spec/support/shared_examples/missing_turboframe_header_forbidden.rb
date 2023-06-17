# frozen_string_literal: true

RSpec.shared_examples "request missing the Turbo-Frame header is forbidden" do
  it "returns a 403 response if the Turbo-Frame header is missing" do
    subject
    expect(response).to have_http_status :forbidden
  end
end
