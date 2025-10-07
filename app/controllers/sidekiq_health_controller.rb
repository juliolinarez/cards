class SidekiqHealthController < ApplicationController
  before_action :authenticate_user!

  def check
    email = params[:email] || current_user.email

    # Enqueue the job
    SidekiqHealthCheckJob.perform_async(email)

    flash[:notice] = "✅ Health check enviado! Revisa tu email: #{email}"
    redirect_back_or_to root_path
  rescue => e
    flash[:alert] = "❌ Error enviando health check: #{e.message}"
    redirect_back_or_to root_path
  end
end
