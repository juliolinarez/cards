require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  before do
    render
  end

  it "displays the Proxyfield logo and branding" do
    expect(rendered).to include("PROXYFIELD")
    expect(rendered).to include("A modern deck builder for Magic: The Gathering®")
  end

  it "includes the hero section with gradient background" do
    expect(rendered).to include("bg-gradient-to-br from-purple-900 via-purple-800 to-blue-900")
    expect(rendered).to include("relative min-h-screen")
  end

  it "has a search interface" do
    expect(rendered).to include('placeholder="Search decks"')
    expect(rendered).to include("Search")
  end

  it "includes navigation buttons" do
    expect(rendered).to include("Decks")
    expect(rendered).to include("Cards")
    expect(rendered).to include("Brewers")
    expect(rendered).to include("Advanced")
  end

  it "shows feature highlights" do
    expect(rendered).to include("Why Choose Proxyfield?")
    expect(rendered).to include("Powerful Search")
    expect(rendered).to include("Intuitive Deck Builder")
    expect(rendered).to include("Community Driven")
  end

  it "has a proper page title" do
    expect(view.content_for(:title)).to eq("Proxyfield - A modern deck builder for Magic: The Gathering®")
  end

  context "when user is not signed in" do
    before do
      allow(view).to receive(:user_signed_in?).and_return(false)
      render
    end

    it "shows sign up and sign in links" do
      expect(rendered).to include("Sign Up - It&#39;s Free!")
      expect(rendered).to include("Learn More")
    end
  end

  context "when user is signed in" do
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      render
    end

    it "shows user-specific call to action" do
      expect(rendered).to include("Start Building")
      expect(rendered).to include("Browse Decks")
    end
  end
end
