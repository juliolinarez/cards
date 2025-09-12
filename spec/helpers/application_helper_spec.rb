require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "module" do
    it "is a module" do
      expect(ApplicationHelper).to be_a(Module)
    end

    it "is included in views" do
      expect(helper).to be_a(ApplicationHelper)
    end
  end
end
