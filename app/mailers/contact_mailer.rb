class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail(from: @contact.email, to: ENV['TOMAIL'], subject: 'お問合せ内容')
  end
end
