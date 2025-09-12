class HotwireTestController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @message = "Haz clic en cualquier botón para probar Hotwire"
    @counter = session[:counter] || 0
    render HotwireTestPageComponent.new(message: @message, counter: @counter)
  end

  def button_one
    @message = "¡Botón 1 presionado! Hotwire funcionando correctamente"
    @counter = (session[:counter] || 0) + 1
    session[:counter] = @counter

    render TurboStreamUpdateComponent.new(
      message: @message,
      counter: @counter,
      alert_class: "alert-success"
    )
  end

  def button_two
    @message = "¡Botón 2 activado! AJAX con Turbo Streams"
    @counter = (session[:counter] || 0) + 1
    session[:counter] = @counter

    render TurboStreamUpdateComponent.new(
      message: @message,
      counter: @counter,
      alert_class: "alert-warning"
    )
  end

  def button_three
    @message = "¡Botón 3 ejecutado! Sin recarga de página"
    @counter = (session[:counter] || 0) + 1
    session[:counter] = @counter

    render TurboStreamUpdateComponent.new(
      message: @message,
      counter: @counter,
      alert_class: "alert-error"
    )
  end

  def reset_counter
    session[:counter] = 0
    @counter = 0
    @message = "Contador reiniciado"

    render TurboStreamUpdateComponent.new(
      message: @message,
      counter: @counter,
      alert_class: "alert-info"
    )
  end
end
