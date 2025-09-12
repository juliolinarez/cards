# frozen_string_literal: true

class MessageComponent < ApplicationComponent
  def initialize(message:, alert_class: "alert-info")
    @message = message
    @alert_class = alert_class
  end

  private

    attr_reader :message, :alert_class
end
