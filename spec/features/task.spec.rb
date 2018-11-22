require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content 'テストケース１のタイトル'
    expect(page).to have_content 'テストケース２のタイトル'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
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
    expect(page).to have_content 'これはタイトルです。'
    expect(page).to have_content 'これは内容です。'
    expect(page).to have_content '2020年11月20日(金) 20時00分'
    expect(page).to have_content '完了'
    expect(page).to have_content '低'
  end

  scenario "タスク編集のテスト" do
    visit tasks_path
    click_link 'テストケース２のタイトル'
    click_link '編集'
    fill_in 'task_contents', with: '内容を編集しました。'
    choose 'task_priority_priority_high'
    click_button '編集'
    expect(page).to have_content 'テストケース２のタイトル'
    expect(page).to have_content '内容を編集しました。'
    expect(page).to have_content '2050年11月11日(金) 09時00分'
    expect(page).to have_content '完了'
    expect(page).to have_content '高'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    task_titles = all('.task_title').map(&:text)
    expect(task_titles).to eq %w(テストケース１のタイトル テストケース２のタイトル テストケース３のタイトル)
  end

  scenario "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', contents: '失敗テスト', deadline: DateTime.now.end_of_day, status: 'started', priority: 'priority_high')
    expect(task).not_to be_valid
  end

  scenario "deadlineが過去ならバリデーションが通らない" do
    task = Task.new(title: '失敗テスト', contents: '失敗テスト', deadline: DateTime.yesterday, status: 'finished', priority: 'priority_middle')
    expect(task).not_to be_valid
  end

  scenario "すべての項目に内容が記載されていればバリデーションが通る" do
    task = Task.new(title: '成功テスト', contents: '成功テスト', deadline: DateTime.now.end_of_day, status: 'before_start', priority: 'priority_low')
    expect(task).to be_valid
  end

  scenario "終了期限でソートができているかのテスト" do
    visit tasks_path
    click_link '終了期限でソートする'
    task_deadlines = all('.task_deadline').map(&:text)
    expect(task_deadlines).to eq %W(#{'2019年10月10日(木) 12時00分'} #{'2019年11月10日(日) 07時00分'} #{'2050年11月11日(金) 09時00分'})
  end
end
