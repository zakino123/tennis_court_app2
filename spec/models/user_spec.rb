require 'rails_helper'

RSpec.describe User, type: :model do
  it "正しい名前、メール、パスワードがある場合は有効" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "名前がない場合は無効" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがない場合は無効" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  it "パスワードがない場合は無効" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "メールアドレスが重複している場合は無効" do
    user1 = FactoryBot.create(:user, email: "test@example.com")
    user2 = FactoryBot.build(:user, email: "test@example.com")
    user2.valid?
    expect(user2.errors[:email]).to include(I18n.t('errors.messages.taken'))
  end

  it "パスワードが６文字以上は有効" do
    user = FactoryBot.build(:user, password: 'a' * 6 )
    user.valid?
    expect(user).to be_valid
  end

  it "パスワードが６文字未満は無効" do
    user = FactoryBot.build(:user, password: 'a' * 5 )
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end

  it 'メールアドレスは全て小文字で保存' do
    user = FactoryBot.build(:user, email: 'TESTUSER@EXAMPLE.COM')
    user.save
    expect(user.reload.email).to eq 'testuser@example.com'
  end

  it "ユーザー名が30文字以下の場合は有効" do
    user = FactoryBot.build(:user, name: 'a' * 30)
    expect(user).to be_valid
  end

  it "ユーザー名が31文字以上の場合は無効" do
    user = FactoryBot.build(:user, name: 'a' * 31)
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 30))
  end

  it "メールアドレスのフォーマットが正しい場合は有効" do
    addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                   first.last@foo.jp alice+bob@baz.cn]

    addresses.each do |valid_address|
      expect(FactoryBot.build(:user, email: valid_address)).to be_valid
    end
  end

  it "メールアドレスのフォーマットが誤っている場合は無効" do
    addresses = %w[user@example,com user_at_foo.org user.name@example.
                   foo@bar_baz.com foo@bar+baz.com]

    addresses.each do |invalid_address|
      expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
    end
  end

  it "メールアドレスが50文字以下で有効" do
    user = FactoryBot.build(:user, email: "#{'a' * 38}@example.com")
    expect(user).to be_valid
  end

  it "メールアドレスが51文字以上で無効" do
    user = FactoryBot.build(:user, email: "#{'a' * 39}@example.com")
    user.valid?
    expect(user.errors[:email]).to include("は50文字以内で入力してください")
  end

  it "remember_digestがnilの場合falseを返す" do
    user = FactoryBot.create(:user)
    expect(user.authenticated?('')).to be_falsy
  end
end
