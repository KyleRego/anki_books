# frozen_string_literal: true

RSpec.shared_context "when the user is logged in" do
  let(:user) { create(:user) }

  before do
    post login_path, params: { session: { email: user.email,
                                          password: TEST_USER_PASSWORD } }
  end
end
