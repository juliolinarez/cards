# frozen_string_literal: true

class TurboStreamUpdateComponent < ApplicationComponent
  def initialize(message:, counter:, alert_class:)
    @message = message
    @counter = counter
    @alert_class = alert_class
  end

  private

    attr_reader :message, :counter, :alert_class
end
