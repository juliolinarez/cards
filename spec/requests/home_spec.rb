require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "returns http success for root path" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "displays Proxyfield branding" do
      get root_path
      expect(response.body).to include("PROXYFIELD")
      expect(response.body).to include("A modern deck builder for Magic: The Gathering®")
    end

    it "is accessible without authentication" do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response).not_to redirect_to(new_user_session_path)
    end
  end



  context "when user is signed in" do
    let(:user) { create(:user) }

    it "still shows the landing page" do
      # Use Warden's login_as for request specs
      login_as(user, scope: :user)
      get root_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("PROXYFIELD")
    end
  end
end
