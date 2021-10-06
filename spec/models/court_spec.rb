require 'rails_helper'

RSpec.describe Court, type: :model do 
  let(:user) { FactoryBot.create(:user) }
  let(:court) { FactoryBot.create(:court, user_id: user.id) }
  it "正しい値がある場合は有効" do
    expect(court).to be_valid
  end

  it "ユーザーIDがない場合は無効" do
    court.user_id = nil
    court.valid?
    expect(court.errors[:user_id]).to include("を入力してください")
  end

  it "施設名がない場合は無効" do
    court.name = nil
    court.valid?
    expect(court.errors[:name]).to include("を入力してください")
  end

  it "住所がない場合は無効" do
    court.address = nil
    court.valid?
    expect(court.errors[:address]).to include("を入力してください")
  end

  it "値段がない場合は無効" do
    court.price = nil
    court.valid?
    expect(court.errors[:price]).to include("を入力してください")
  end

  it "予約URLがない場合は無効" do
    court.reserve = nil
    court.valid?
    expect(court.errors[:reserve]).to include("を入力してください")
  end

  it "コート数がない場合は無効" do
    court.number = nil
    court.valid?
    expect(court.errors[:number]).to include("を入力してください")
  end

  it "住所が重複している場合は無効" do
    court1 = FactoryBot.create(:court, address: "test")
    court2 = FactoryBot.build(:court, address: "test")
    court2.valid?
    expect(court2.errors[:address]).to include(I18n.t('errors.messages.taken'))
  end

  it "施設名が50文字以下は有効" do
    court.name = 'a' * 50 
    court.valid?
    expect(court).to be_valid
  end

  it "施設名が51文字以上は無効" do
    court.name = 'a' * 51
    court.valid?
    expect(court.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 50))
  end

  it "住所が100文字以下は有効" do
    court.address = 'a' * 100
    court.valid?
    expect(court).to be_valid
  end

  it "住所が101文字以上は無効" do
    court.address = 'a' * 101
    court.valid?
    expect(court.errors[:address]).to include(I18n.t('errors.messages.too_long', count: 100))
  end

  it "価格が10桁以下は有効" do
    court.price = '1' * 10
    court.valid?
    expect(court).to be_valid
  end

  it "価格が11桁以上は無効" do
    court.price = '1' * 11
    court.valid?
    expect(court.errors[:price]).to include(I18n.t('errors.messages.too_long', count: 10))
  end

  it "コート数が10桁以下は有効" do
    court.number = '1' * 10
    court.valid?
    expect(court).to be_valid
  end

  it "コート数が11桁以上は無効" do
    court.number = '1' * 11
    court.valid?
    expect(court.errors[:number]).to include(I18n.t('errors.messages.too_long', count: 10))
  end

  it "備考が200文字以下は有効" do
    court.remarks = 'a' * 200
    court.valid?
    expect(court).to be_valid
  end

  it "備考が201文字以上は無効" do
    court.remarks = 'a' * 201
    court.valid?
    expect(court.errors[:remarks]).to include(I18n.t('errors.messages.too_long', count: 200))
  end
end
