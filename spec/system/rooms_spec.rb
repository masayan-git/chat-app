require 'rails_helper'

RSpec.describe "チャットルームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@room_user.user)
    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)
    # メッセージ情報を５つDBに追加する
    n = 5
    FactoryBot.create_list(:message, n, room_id: @room_user.room.id, user_id: @room_user.user.id)
    # 以下自作
    # n.times do 
    #   post = FactoryBot.build(:message)
    #   posts = post.content
    #   fill_in 'message_content', with: posts
    #   click_on("送信")
    # end
    # binding.pry
    # チャットを終了するボタンをクリックすることで作成した５つのメッセージが削除されていることを期待する
    expect{
      find_link("チャットを終了する", href: room_path(@room_user.room)).click
    }.to change { @room_user.room.messages.count }.by(-n)
    # ルートページに遷移されることを期待する
    expect(current_path).to eq root_path
  end
end
