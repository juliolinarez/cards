require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe "#user_greeting" do
    context "when user is signed in" do
      let(:user) { create(:user, email: "john.doe@example.com") }

      before do
        allow(helper).to receive(:user_signed_in?).and_return(true)
        allow(helper).to receive(:current_user).and_return(user)
      end

      it "returns a personalized greeting" do
        expect(helper.user_greeting).to eq("Welcome back, John!")
      end

      it "capitalizes the first name from email" do
        user.email = "jane.smith@example.com"
        expect(helper.user_greeting).to eq("Welcome back, Jane!")
      end
    end

    context "when user is not signed in" do
      before do
        allow(helper).to receive(:user_signed_in?).and_return(false)
      end

      it "returns a general greeting" do
        expect(helper.user_greeting).to eq("Welcome to Proxyfield!")
      end
    end
  end

  describe "#feature_card" do
    let(:title) { "Fast Search" }
    let(:description) { "Find cards quickly with our advanced search" }

    it "generates a feature card with proper styling" do
      result = helper.feature_card(title, description)

      expect(result).to include("bg-white bg-opacity-10 backdrop-blur-lg rounded-xl")
      expect(result).to include("Fast Search")
      expect(result).to include("Find cards quickly with our advanced search")
    end

    it "includes proper CSS classes for styling" do
      result = helper.feature_card(title, description)

      expect(result).to include("text-xl font-semibold text-white mb-2")
      expect(result).to include("text-purple-200 text-sm")
      expect(result).to include("w-12 h-12 bg-purple-500 rounded-lg")
    end

    it "handles title and description parameters correctly" do
      result = helper.feature_card(title, description)

      expect(result).to be_present
      expect(result).to include(title)
      expect(result).to include(description)
    end
  end
end
