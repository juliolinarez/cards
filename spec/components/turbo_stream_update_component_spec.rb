require 'rails_helper'

RSpec.describe TurboStreamUpdateComponent, type: :component do
  it "renders the message" do
    component = described_class.new(message: "Test message", counter: 1, alert_class: "alert-info")
    rendered = render_inline(component)

    expect(rendered.text).to include("Test message")
  end

  it "renders the counter" do
    component = described_class.new(message: "Test", counter: 5, alert_class: "alert-info")
    rendered = render_inline(component)

    expect(rendered.text).to include("5")
  end

  it "uses the provided alert class" do
    component = described_class.new(message: "Test", counter: 1, alert_class: "alert-success")
    rendered = render_inline(component)

    expect(rendered.to_html).to include("alert-success")
  end

  it "renders all required attributes" do
    component = described_class.new(
      message: "Custom message",
      counter: 10,
      alert_class: "alert-warning"
    )
    rendered = render_inline(component)

    expect(rendered.text).to include("Custom message")
    expect(rendered.text).to include("10")
    expect(rendered.to_html).to include("alert-warning")
  end

  it "renders turbo stream updates" do
    component = described_class.new(message: "Test", counter: 1, alert_class: "alert-info")
    rendered = render_inline(component)

    expect(rendered.to_html).to include("turbo-stream")
    expect(rendered.to_html).to include("message-display")
    expect(rendered.to_html).to include("counter-display")
  end
end
