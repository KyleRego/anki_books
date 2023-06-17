# frozen_string_literal: true

RSpec.shared_examples "user not logged in gets redirected" do
  # rubocop:disable RSpec/MultipleExpectations
  it "redirects a not logged in user to the homepage" do
    subject
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq(ApplicationController::NOT_LOGGED_IN_FLASH_MESSAGE)
  end
  # rubocop:enable RSpec/MultipleExpectations
end
