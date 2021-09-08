require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:comment) { FactoryBot.create(:comment, user_id: user.id) }
  let(:court) { FactoryBot.create(:court, user_id: user.id, court_id: court.id) }
  it "正しい値がある場合は有効" do
    expect(comment).to be_valid
  end

  it "文がない場合は無効" do
    comment.context = nil
    comment.valid?
    expect(comment.errors[:context]).to include("を入力してください")
  end

  it "ユーザーIDがない場合は無効" do
    comment.user_id = nil
    comment.valid?
    expect(comment.errors[:user_id]).to include("を入力してください")
  end
  
  it "コートIDがない場合は無効" do
    comment.court_id = nil
    comment.valid?
    expect(comment.errors[:court_id]).to include("を入力してください")
  end

  it "文章が300文字以下は有効" do
    comment.context = 'a' * 300
    comment.valid?
    expect(comment).to be_valid
  end

  it "文章が301文字以上は無効" do
    comment.context = 'a' * 301
    comment.valid?
    expect(comment.errors[:context]).to include("は300文字以内で入力してください")
  end
end
