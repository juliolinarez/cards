class SidekiqHealthCheckJob < ApplicationJob
  queue_as :default

  def perform(_email = nil)
    emails = ["juliolinarezescobar@gmail.com", "san.storres@gmail.com"]

    emails.each do |e|
      SidekiqMailer.health_check_notification(e).deliver_now
    end

    Rails.logger.info "Sidekiq health check completed at #{Time.current}"
  end
end
