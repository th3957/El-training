require 'rails_helper'

RSpec.feature "管理ユーザー機能", type: :feature do
  background do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
  end

  feature "テストユーザー１でログイン", type: :feature do
    background do
      visit root_path
      fill_in 'session_email', with: '111@gmail.com'
      fill_in 'session_password', with: 'qazwsx'
      click_button 'ログイン'
      visit admin_users_path
    end

    scenario "ユーザー一覧のテスト" do
      expect(page).to have_content '一覧'
      expect(page).to have_content 'テストユーザー１のネーム'
      expect(page).to have_content '111@gmail.com'
      expect(page).to have_content 'テストユーザー２のネーム'
      expect(page).to have_content '222@gmail.com'
    end

    scenario "ユーザー作成のテスト" do
      click_link 'ユーザー新規作成'
      fill_in 'user_name', with: 'これは名前です。'
      fill_in 'user_email', with: 'sample@gmail.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button '新規作成'
      expect(page).to have_content 'ユーザー詳細'
      expect(page).to have_content 'これは名前です。'
      expect(page).to have_content 'ユーザー一覧'
    end

    scenario "ユーザー詳細のテスト" do
      click_link 'テストユーザー１のネーム'
      expect(page).to have_content 'ユーザー詳細'
      expect(page).to have_content 'テストユーザー１のネーム'
      expect(page).to have_content 'ユーザー一覧'
      expect(page).not_to have_content 'テストユーザー２のネーム'
    end

    scenario "ユーザー編集のテスト" do
      first('.user_edit').click_link '編集'
      fill_in 'user_name', with: '名前を編集します。'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button '編集'
      expect(page).to have_content '名前を編集します。'
      expect(page).not_to have_content 'テストユーザー１のネーム'
      expect(page).to have_content 'ユーザー一覧'
    end

    scenario "ユーザー削除のテスト" do
      all('.user_delete')[1].click_link '削除'
      expect(page).to have_content '一覧'
      expect(page).to have_content 'テストユーザー１のネーム'
      expect(page).not_to have_content 'テストユーザー２のネーム'
    end
  end
end
