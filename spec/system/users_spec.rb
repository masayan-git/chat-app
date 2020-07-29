require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do

  it 'ログインしていない場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path
  end

  it 'ログインに成功し、ルートパスに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインインページへ移動する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンをクリックする
    click_on("Log in")
    # ルートページに遷移することを期待する
    expect(current_path).to eq root_path
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインインページへ移動する
    visit new_user_session_path
    # 誤ったユーザー情報を入力する
    fill_in 'Email', with:"testtt"
    fill_in 'Password', with:"sasasasasaaa"
    # ログインボタンをクリックする
    click_on("Log in")
    # サインインページに遷移していることを期待する
    expect(current_path).to eq new_user_session_path
  end
end
