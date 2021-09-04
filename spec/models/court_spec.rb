require 'rails_helper'

RSpec.describe Court, type: :model do
  it "正しい名前、メール、パスワードがある場合は有効" do
    court = FactoryBot.build(:court)
    expect(court).to be_valid
  end

  it "施設名がない場合は無効" do
    court = FactoryBot.build(:court, name: nil)
    court.valid?
    expect(court.errors[:name]).to include("を入力してください")
  end

  it "住所がない場合は無効" do
    court = FactoryBot.build(:court, address: nil)
    court.valid?
    expect(court.errors[:address]).to include("を入力してください")
  end

  it "施設名が50文字以下は有効" do
    court = FactoryBot.build(:court, name: 'a' * 50 )
    court.valid?
    expect(court).to be_valid
  end

  it "施設名が51文字以上は無効" do
    court = FactoryBot.build(:court, name: 'a' * 51 )
    court.valid?
    expect(court.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 50))
  end

  it "住所が100文字以下は有効" do
    court = FactoryBot.build(:court, address: 'a' * 100 )
    court.valid?
    expect(court).to be_valid
  end

  it "住所が101文字以上は無効" do
    court = FactoryBot.build(:court, address: 'a' * 101 )
    court.valid?
    expect(court.errors[:address]).to include(I18n.t('errors.messages.too_long', count: 100))
  end
end
