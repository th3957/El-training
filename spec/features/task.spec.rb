require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
  end

  scenario "タスク一覧のテスト" do
    Task.create!(title: 'test_task_01', contents: 'testtesttest', deadline: DateTime.now) # priority: '1', state: '1'
    Task.create!(title: 'test_task_02', contents: 'samplesample', deadline: DateTime.now) # priority: '2', state: '2'
    visit tasks_path
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'test_task_02'
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
    # fill_in 'task_priority', with: '1'
    # fill_in 'task_state', with: '1'
    click_button '新規作成'
    expect(page).to have_content 'これはタイトルです。'
    expect(page).to have_content 'これは内容です。'
    expect(page).to have_content '2018年11月18日(日) 20時00分'
  end

  scenario "タスク編集のテスト" do
    Task.create!(title: 'test_task_03', contents: 'testtesttesttest', deadline: DateTime.now,) # priority: '3', state: '3'
    visit tasks_path
    click_link 'test_task_03'
    click_link '編集'
    fill_in 'task_contents', with: '内容を編集しました。'
    click_button '編集'
    expect(page).to have_content 'test_task_03'
    expect(page).to have_content '内容を編集しました。'
  end
end
