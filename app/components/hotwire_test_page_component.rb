# frozen_string_literal: true

class HotwireTestPageComponent < ApplicationComponent
  def initialize(message:, counter:)
    @message = message
    @counter = counter
  end

  private

    attr_reader :message, :counter
end
