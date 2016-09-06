class UserMailer < ActionMailer::Base
  default :from => "whistlblowrs@gmail.com"

  def new_investigator_email(email, password)
    @password = password
    mail :to => email, :subject => "New Registration for Project Six Tip/Complaint App"
  end

end
