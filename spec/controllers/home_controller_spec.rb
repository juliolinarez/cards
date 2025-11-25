require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "is accessible without authentication" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).not_to redirect_to(new_user_session_path)
    end

    it "skips authentication" do
      # Verify that the action is accessible without authentication
      get :index
      expect(response).to have_http_status(:success)
    end

    context "when user is signed in" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "still allows access" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
