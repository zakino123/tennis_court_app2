require 'rails_helper'

RSpec.describe 'ContactMailer', type: :mailer do
  describe 'メール送信' do
    let(:contact) { FactoryBot.create(:contact) }
    let(:mail) { ContactMailer.send_mail(contact).deliver }

    it '送信メール内容' do
      expect(mail.subject).to eq('お問合せ内容')
      expect(mail.to).to eq(['maramara3104@gmail.com'])
      expect(mail.from).to eq(['test@example.com'])
    end
  end
end
