require 'rails_helper'

RSpec.feature "ラベル添付機能", type: :feature do
  background do
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
  end

  scenario "タイトルが空ならバリデーションが通らない" do
    label = Label.new(title: '')
    expect(label).not_to be_valid
  end

  feature "テストユーザー１でログイン", type: :feature do
    background do
      visit root_path
      fill_in 'session_email', with: '111@gmail.com'
      fill_in 'session_password', with: 'qazwsx'
      click_button 'ログイン'
    end

    scenario "ラベルを添付してタスクを作成" do
      visit new_task_path
      check 'task_label_ids_1'
      fill_in 'task_title', with: 'これはタイトルです。'
      fill_in 'task_contents', with: 'これは内容です。'
      choose 'task_status_finished'
      choose 'task_priority_priority_low'
      select '2020', from: 'task_deadline_1i'
      select '11月', from: 'task_deadline_2i'
      select '20', from: 'task_deadline_3i'
      select '20', from: 'task_deadline_4i'
      select '00', from: 'task_deadline_5i'
      click_button '新規作成'
      expect(page).to have_content 'テストラベル１'
      expect(page).to have_content 'これはタイトルです。'
      expect(page).to have_content 'これは内容です。'
      expect(page).to have_content '2020年11月20日(金) 20時00分'
      expect(page).to have_content '完了'
      expect(page).to have_content '低'
    end

    scenario "ラベルでタスクを検索" do
    end
  end
end
