require 'rails_helper'

RSpec.describe 'SiteLayoutTest', type: :feature do
  before { visit root_path }
  subject { page }
  scenario 'layout links' do
    is_expected.to have_link nil, href: root_path, count: 2
    is_expected.to have_link 'ログイン', href: login_path
    is_expected.to have_link '新規登録', href: user_create_path
    is_expected.to have_link 'お問い合わせ', href: new_contact_path
  end
end
