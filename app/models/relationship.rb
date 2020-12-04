class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # フォロー、フォロワーもuserモデル
  # 存在しないモデルの為、class_nameで関連先のモデルを参照する際の名前を変更している
  # class_nameでUserをフォローとフォロワーに分ける
end
