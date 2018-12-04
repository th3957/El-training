require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:fourth_task)
  end

  scenario "タイトルが空ならバリデーションが通らない" do
    task = User.first.tasks.build(title: '', contents: '失敗テスト', deadline: DateTime.now.end_of_day, status: 'started', priority: 'priority_high')
    expect(task).not_to be_valid
  end

  scenario "終了期限が過去ならバリデーションが通らない" do
    task = User.first.tasks.build(title: '失敗テスト', contents: '失敗テスト', deadline: DateTime.yesterday, status: 'finished', priority: 'priority_middle')
    expect(task).not_to be_valid
  end

  scenario "すべての項目が正しく記載されていればバリデーションが通る" do
    task = User.first.tasks.build(title: '成功テスト', contents: '成功テスト', deadline: DateTime.now.end_of_day, status: 'before_start', priority: 'priority_low')
    expect(task).to be_valid
  end

  feature "テストユーザー１でログイン", type: :feature do
    background do
      visit root_path
      fill_in 'session_email', with: '111@gmail.com'
      fill_in 'session_password', with: 'qazwsx'
      click_button 'ログイン'
    end

    scenario "タスク一覧のテスト" do
      visit tasks_path
      expect(page).to have_content 'テストケース１のタイトル'
      expect(page).not_to have_content 'テストケース２のタイトル'
      expect(page).not_to have_content 'テストケース３のタイトル'
      expect(page).not_to have_content 'テストケース４のタイトル'
    end

    scenario "タスク作成のテスト" do
      visit new_task_path
      all('#task_title')[1].set('これはタイトルです。')
      fill_in 'task_contents', with: 'これは内容です。'
      choose 'task_status_finished'
      choose 'task_priority_priority_low'
      select '2020', from: 'task_deadline_1i'
      select '11月', from: 'task_deadline_2i'
      select '20', from: 'task_deadline_3i'
      select '20', from: 'task_deadline_4i'
      select '00', from: 'task_deadline_5i'
      click_button '新規作成'
      expect(page).to have_content 'これはタイトルです。'
      expect(page).to have_content 'これは内容です。'
      expect(page).to have_content '2020年11月20日(金) 20時00分'
      expect(page).to have_content '完了'
      expect(page).to have_content '低'
    end
  end

  feature "テストユーザー２でログイン", type: :feature do
    background do
      visit root_path
      fill_in 'session_email', with: '222@gmail.com'
      fill_in 'session_password', with: 'edc293'
      click_button 'ログイン'
    end

    scenario "タスク編集のテスト" do
      visit tasks_path
      click_link 'テストケース２のタイトル'
      click_link '編集'
      all('#task_title')[1].set('編集されたテストケース２のタイトル')
      fill_in 'task_contents', with: 'テストケース２のコンテンツ内容を編集しました。'
      choose 'task_status_started'
      choose 'task_priority_priority_low'
      select '12', from: 'task_deadline_4i'
      click_button '編集'
      expect(page).to have_content '編集されたテストケース２のタイトル'
      expect(page).to have_content 'テストケース２のコンテンツ内容を編集しました。'
      expect(page).to have_content '2050年11月11日(金) 12時00分'
      expect(page).to have_content '着手中'
      expect(page).to have_content '低'
    end

    scenario "タスクが作成日時の昇順に並んでいるかのテスト" do
      visit tasks_path
      task_titles = all('.task_title').map(&:text)
      expect(task_titles).to eq %w(テストケース４のタイトル テストケース３のタイトル テストケース２のタイトル)
    end

    scenario "終了期限でソートができているかのテスト" do
      visit tasks_path
      click_link '終了期限でソートする'
      task_deadlines = all('.task_deadline').map(&:text)
      expect(task_deadlines).to eq %W(#{'2019年10月10日(木) 12時00分'} #{'2020年11月11日(水) 06時00分'} #{'2050年11月11日(金) 09時00分'})
    end

    scenario "優先順位でソートができているかのテスト" do
      visit tasks_path
      click_link '優先順位でソートする'
      task_priorities = all('.task_priority').map(&:text)
      expect(task_priorities).to eq %w(高 中 低)
    end

    scenario "タイトル名で絞り込み検索のテスト" do
      visit tasks_path
      all('#task_title')[0].set('２のタイトル')
      click_button '検索'
      expect(page).to have_content 'テストケース２のタイトル'
      expect(page).to have_content '2050年11月11日(金) 09時00分'
      expect(page).not_to have_content 'テストケース１のタイトル'
      expect(page).not_to have_content 'テストケース３のタイトル'
      expect(page).not_to have_content 'テストケース４のタイトル'
    end

    scenario "タイトル名と進捗状況で絞り込み検索のテスト" do
      visit tasks_path
      all('#task_title')[0].set('テストケース')
      select '未着手', from: 'task_status'
      click_button '検索'
      expect(page).to have_content 'テストケース３のタイトル'
      expect(page).to have_content '2019年10月10日(木) 12時00分'
      expect(page).not_to have_content 'テストケース１のタイトル'
      expect(page).not_to have_content 'テストケース２のタイトル'
      expect(page).not_to have_content 'テストケース４のタイトル'
    end

    scenario "進捗状況と優先順位で絞り込み検索のテスト" do
      visit tasks_path
      select '着手中', from: 'task_status'
      select '中', from: 'task_priority'
      click_button '検索'
      expect(page).to have_content 'テストケース４のタイトル'
      expect(page).to have_content '2020年11月11日(水) 06時00分'
      expect(page).to_not have_content 'テストケース１のタイトル'
      expect(page).to_not have_content 'テストケース２のタイトル'
      expect(page).to_not have_content 'テストケース３のタイトル'
    end
  end
end
