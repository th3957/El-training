require 'rails_helper'

RSpec.feature "ユーザー機能", type: :feature do
  background do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
  end

  scenario "ユーザー作成のテスト" do
    visit new_user_path
    fill_in 'user_name', with: 'これは名前です。'
    fill_in 'user_email', with: 'sample@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button '新規作成'
    expect(page).to have_content 'ユーザー詳細'
    expect(page).to have_content 'これは名前です。'
  end

  scenario "名前が空ならバリデーションが通らない" do
    user = User.new(name: '', email: 'sample@gmail.com', password: 'password', password_confirmation: 'password')
    expect(user).not_to be_valid
  end

  scenario "Eメールが重複するとバリデーションが通らない" do
    user = User.new(name: '失敗テスター', email: '111@gmail.com', password: 'password', password_confirmation: 'password')
    expect(user).not_to be_valid
  end

  scenario "入力されたパスワードとパスワード確認が同じでないとバリデーションが通らない" do
    user = User.new(name: '失敗テスター', email: 'sample@gmail.com', password: 'password', password_confirmation: 'passwor')
    expect(user).not_to be_valid
  end

  scenario "すべての項目が正しく記載されていればバリデーションが通る" do
    user = User.new(name: '成功テスター', email: 'sample@gmail.com', password: 'password', password_confirmation: 'password')
    expect(user).to be_valid
  end

  scenario "パスワードを間違えるとログインできない" do
    visit root_path
    fill_in 'session_email', with: '111@gmail.com'
    fill_in 'session_password', with: 'q'
    click_button 'ログイン'
    expect(page).to have_content 'You failed to log in. Please check your email and password.'
    expect(page).not_to have_content 'テストユーザー１のネーム'
  end

  scenario "ログインしないでタスク一覧へ行こうとするとログインページに飛ぶ" do
    visit tasks_path
    expect(page).to have_content 'ログイン'
    expect(page).not_to have_content '一覧'
  end

  feature "テストユーザー１でログイン", type: :feature do
    background do
      visit root_path
      fill_in 'session_email', with: '111@gmail.com'
      fill_in 'session_password', with: 'qazwsx'
      click_button 'ログイン'
    end

    scenario "ユーザー詳細のテスト" do
      click_link 'personal page'
      expect(page).to have_content 'テストユーザー１のネーム'
      expect(page).not_to have_content 'テストユーザー２のネーム'
    end

    scenario "ログアウトのテスト" do
      click_link 'logout'
      expect(page).to have_content 'Logout completed successfully.'
    end

    scenario "ログイン中にユーザー新規作成に行こうとすると詳細ページに飛ぶ" do
      visit new_user_path
      expect(page).to have_content 'ユーザー詳細'
      expect(page).not_to have_content 'ユーザー新規作成'
    end

    scenario "ログイン中に他ユーザーの詳細ページに行こうとするとログインページに飛ぶ" do
      visit 'http://localhost:3000/users/10000'
      expect(page).to have_content 'ログイン'
      expect(page).not_to have_content 'ユーザー詳細'
    end
  end
end
