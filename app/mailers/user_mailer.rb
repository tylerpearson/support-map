class UserMailer < ActionMailer::Base
  default from: "Endorsement notifier <tyler@newmediacampaigns.com>"

  def admin_notification_email(user)
    @user = user
    mail(to: "tyler@newmediacampaigns.com", subject: "#{@user.name} just made an endorsement")
  end
end
