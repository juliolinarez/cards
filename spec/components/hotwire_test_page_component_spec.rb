require 'rails_helper'

RSpec.describe HotwireTestPageComponent, type: :component do
  it "renders the message" do
    component = described_class.new(message: "Test message", counter: 0)
    rendered = render_inline(component)

    expect(rendered.text).to include("Test message")
  end

  it "renders the counter" do
    component = described_class.new(message: "Test", counter: 5)
    rendered = render_inline(component)

    expect(rendered.text).to include("5")
  end

  it "renders with zero counter" do
    component = described_class.new(message: "Test", counter: 0)
    rendered = render_inline(component)

    expect(rendered.text).to include("0")
  end

  it "renders both message and counter" do
    component = described_class.new(message: "Custom message", counter: 10)
    rendered = render_inline(component)

    expect(rendered.text).to include("Custom message")
    expect(rendered.text).to include("10")
  end

  it "renders the page title" do
    component = described_class.new(message: "Test", counter: 0)
    rendered = render_inline(component)

    expect(rendered.text).to include("Prueba de Hotwire")
  end
end
