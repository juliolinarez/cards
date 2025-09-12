# frozen_string_literal: true

class CounterComponent < ApplicationComponent
  def initialize(counter:)
    @counter = counter
  end

  private

    attr_reader :counter
end
