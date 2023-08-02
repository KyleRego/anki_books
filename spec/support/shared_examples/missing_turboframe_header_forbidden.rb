# frozen_string_literal: true

RSpec.shared_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response" do
  it "returns a 400 (Bad Request) response if the Turbo-Frame header is missing in the request headers" do
    subject
    expect(response).to have_http_status :bad_request
  end
end
