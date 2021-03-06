class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'

    @body[:url]  = "http://www.socialbite.com/activate/#{user.activation_code}"

  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://socialbite.com/"
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "socialbiteevents@gmail.com"
      @subject     = "[SocialBite.com] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
