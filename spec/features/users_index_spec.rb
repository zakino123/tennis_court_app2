# RSpec.feature "Index", type: :feature do
#   FactoryBot.create_list(:user, 31)
#   describe "ユーザー一覧画面のページリンク確認" do
#     before do
#       visit user_create_path
#       fill_in 'ニックネーム', with: 'testuser'
#       fill_in 'メールアドレス', with: 'testuser@example.com'
#       fill_in 'パスワード', with: 'password'
#       fill_in 'パスワード(確認用)', with: 'password'
#       click_button 'ユーザー作成'
#     end
#     it "ページリンク表示成功" do
#       click_link "ユーザー一覧"
#       # is_expected.to have_link "Next"
#     end
#   end
# end