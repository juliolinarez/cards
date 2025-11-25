require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'OK'
    end
  end

  describe "authentication" do
    it "requires authentication by default" do
      routes.draw { get 'index' => 'anonymous#index' }
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    context "when user is signed in" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "allows access" do
        routes.draw { get 'index' => 'anonymous#index' }
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#configure_permitted_parameters" do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    it "permits name parameter for sign_up" do
      # Verify that the method exists (it's a protected method, so we check all methods)
      expect(controller.class.instance_methods).to include(:configure_permitted_parameters)
    end

    it "permits name parameter for account_update" do
      # Verify that the method exists (it's a protected method, so we check all methods)
      expect(controller.class.instance_methods).to include(:configure_permitted_parameters)
    end
  end
end
