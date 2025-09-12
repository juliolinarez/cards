require 'rails_helper'

RSpec.describe MessageComponent, type: :component do
  it "renders the message" do
    component = described_class.new(message: "Test message")
    rendered = render_inline(component)

    expect(rendered.text).to include("Test message")
  end

  it "uses default alert-info class" do
    component = described_class.new(message: "Test message")
    rendered = render_inline(component)

    expect(rendered.to_html).to include("alert-info")
  end

  it "uses custom alert class when provided" do
    component = described_class.new(message: "Test message", alert_class: "alert-success")
    rendered = render_inline(component)

    expect(rendered.to_html).to include("alert-success")
  end

  it "renders with different alert classes" do
    %w[alert-success alert-warning alert-error alert-info].each do |alert_class|
      component = described_class.new(message: "Test", alert_class: alert_class)
      rendered = render_inline(component)
      expect(rendered.to_html).to include(alert_class)
    end
  end
end
