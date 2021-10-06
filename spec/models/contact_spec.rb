require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { FactoryBot.create(:contact) }

  it "正しい名前、メール、メッセージがある場合は有効" do
    expect(contact).to be_valid
  end

  it "名前がない場合は無効" do
    contact.name = nil
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがない場合は無効" do
    contact.email = nil
    contact.valid?
    expect(contact.errors[:email]).to include("を入力してください")
  end
  
  it "メッセージがない場合は無効" do
    contact.message = nil
    contact.valid?
    expect(contact.errors[:message]).to include("を入力してください")
  end

  it "名前が30文字以下は有効" do
    contact.name = 'a' * 30
    contact.valid?
    expect(contact).to be_valid
  end

  it "名前が31文字以上は無効" do
    contact.name = 'a' * 31
    contact.valid?
    expect(contact.errors[:name]).to include("は30文字以内で入力してください")
  end

  it "メールアドレスが50文字以下で有効" do
    contact.email = "#{'a' * 38}@example.com"
    expect(contact).to be_valid
  end

  it "メールアドレスが51文字以上で無効" do
    contact.email = "#{'a' * 39}@example.com"
    contact.valid?
    expect(contact.errors[:email]).to include("は50文字以内で入力してください")
  end

  it "メッセージが500文字以下の場合は有効" do
    contact.message = 'a' * 500
    expect(contact).to be_valid
  end

  it "メッセージが501文字以上の場合は無効" do
    contact.message = 'a' * 501
    contact.valid?
    expect(contact.errors[:message]).to include(I18n.t('errors.messages.too_long', count: 500))
  end

  it "メールアドレスのフォーマットが正しい場合は有効" do
    addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                   first.last@foo.jp alice+bob@baz.cn]

    addresses.each do |valid_address|
      expect(FactoryBot.build(:contact, email: valid_address)).to be_valid
    end
  end

  it "メールアドレスのフォーマットが誤っている場合は無効" do
    addresses = %w[user@example,com user_at_foo.org user.name@example.
                   foo@bar_baz.com foo@bar+baz.com]

    addresses.each do |invalid_address|
      expect(FactoryBot.build(:contact, email: invalid_address)).to be_invalid
    end
  end

  

  it "remember_digestがnilの場合falseを返す" do
    user = FactoryBot.create(:user)
    expect(user.authenticated?('')).to be_falsy
  end
end
