class SidekiqMailer < ApplicationMailer
  default from: "juliolinarezescobar@gmail.com"

  def health_check_notification(email)
    @timestamp = Time.current
    @hostname = ENV["FLY_MACHINE_ID"] || Socket.gethostname
    @sidekiq_stats = Sidekiq::Stats.new

    mail(
      to: email,
      subject: "✅ Sidekiq está funcionando - #{@hostname}",
      template_path: "sidekiq_mailer",
      template_name: "health_check_notification"
    )
  end
end
