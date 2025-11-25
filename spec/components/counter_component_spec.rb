require 'rails_helper'

RSpec.describe CounterComponent, type: :component do
  it "renders the counter value" do
    component = described_class.new(counter: 5)
    rendered = render_inline(component)

    expect(rendered.text).to include("5")
    expect(rendered.to_html).to include("stat-value")
  end

  it "renders with different counter values" do
    component = described_class.new(counter: 10)
    rendered = render_inline(component)

    expect(rendered.text).to include("10")
  end

  it "renders with zero counter" do
    component = described_class.new(counter: 0)
    rendered = render_inline(component)

    expect(rendered.text).to include("0")
  end
end
