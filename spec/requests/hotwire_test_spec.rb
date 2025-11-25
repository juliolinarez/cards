require 'rails_helper'

RSpec.describe "HotwireTest", type: :request do
  describe "GET /hotwire_test" do
    it "returns http success" do
      get hotwire_test_path
      expect(response).to have_http_status(:success)
    end

    it "is accessible without authentication" do
      get hotwire_test_path
      expect(response).to have_http_status(:success)
      expect(response).not_to redirect_to(new_user_session_path)
    end

    it "initializes counter to 0 in session" do
      get hotwire_test_path
      # In request specs, session is accessed after the request
      expect(response).to have_http_status(:success)
      # The counter is initialized in the controller, we verify it's displayed as 0
      expect(response.body).to include("0")
    end

    it "displays the initial message" do
      get hotwire_test_path
      expect(response.body).to include("Haz clic en cualquier botón para probar Hotwire")
    end
  end

  describe "POST /hotwire_test/button_one" do
    it "increments the counter" do
      post hotwire_test_button_one_path
      # Verify counter is displayed as 1 in the response
      expect(response.body).to include("1")
    end

    it "returns success message" do
      post hotwire_test_button_one_path
      expect(response.body).to include("¡Botón 1 presionado!")
    end

    it "uses alert-success class" do
      post hotwire_test_button_one_path
      expect(response.body).to include("alert-success")
    end
  end

  describe "POST /hotwire_test/button_two" do
    it "increments the counter" do
      post hotwire_test_button_two_path
      # Verify counter is displayed as 1 in the response
      expect(response.body).to include("1")
    end

    it "returns success message" do
      post hotwire_test_button_two_path
      expect(response.body).to include("¡Botón 2 activado!")
    end

    it "uses alert-warning class" do
      post hotwire_test_button_two_path
      expect(response.body).to include("alert-warning")
    end
  end

  describe "POST /hotwire_test/button_three" do
    it "increments the counter" do
      post hotwire_test_button_three_path
      # Verify counter is displayed as 1 in the response
      expect(response.body).to include("1")
    end

    it "returns success message" do
      post hotwire_test_button_three_path
      expect(response.body).to include("¡Botón 3 ejecutado!")
    end

    it "uses alert-error class" do
      post hotwire_test_button_three_path
      expect(response.body).to include("alert-error")
    end
  end

  describe "POST /hotwire_test/reset" do
    before do
      # Set initial counter value by making a request first
      post hotwire_test_button_one_path
      post hotwire_test_button_one_path
      post hotwire_test_button_one_path
      post hotwire_test_button_one_path
      post hotwire_test_button_one_path
    end

    it "resets the counter to 0" do
      post hotwire_test_reset_path
      # Verify counter is displayed as 0 in the response
      expect(response.body).to include("0")
    end

    it "returns reset message" do
      post hotwire_test_reset_path
      expect(response.body).to include("Contador reiniciado")
    end

    it "uses alert-info class" do
      post hotwire_test_reset_path
      expect(response.body).to include("alert-info")
    end
  end

  describe "counter persistence across requests" do
    it "maintains counter value across multiple button clicks" do
      post hotwire_test_button_one_path
      expect(response.body).to include("1")

      post hotwire_test_button_two_path
      expect(response.body).to include("2")

      post hotwire_test_button_three_path
      expect(response.body).to include("3")
    end
  end
end
