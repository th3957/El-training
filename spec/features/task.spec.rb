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
    select '2018', from: 'task_deadline_1i'
    select '11月', from: 'task_deadline_2i'
    select '18', from: 'task_deadline_3i'
    select '20', from: 'task_deadline_4i'
    select '00', from: 'task_deadline_5i'
    click_button '新規作成'
    expect(page).to have_content 'これはタイトルです。'
    expect(page).to have_content 'これは内容です。'
    expect(page).to have_content '2018年11月18日(日) 20時00分'
  end

  scenario "タスク編集のテスト" do
    visit tasks_path
    click_link 'テストケース２のタイトル'
    click_link '編集'
    fill_in 'task_contents', with: '内容を編集しました。'
    click_button '編集'
    expect(page).to have_content 'テストケース２のタイトル'
    expect(page).to have_content '内容を編集しました。'
    expect(page).to have_content '2050年11月11日(金) 09時00分'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    task_titles = all('.task_title').map(&:text)
    expect(task_titles).to eq %w(テストケース１のタイトル テストケース２のタイトル テストケース３のタイトル)
  end
end
