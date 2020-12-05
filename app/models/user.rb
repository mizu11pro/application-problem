class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  # フォロー機能
  # フォローしている人のデータ取得
  has_many :of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #  has_many :followers, through: :of_relationships, source: :follower
  # フォローしている人のデータをrelationship(中間テーブルを通して)相手側(フォローしている人)と紐付け

  # フォローされている人のデータ取得
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #  has_many :followings, through: :relationships, source: :followed
  # フォローしてくれている人のデータをrelationshipを通して相手側(自分のフォロワー)と紐付け

  # 相手目線
  # 自分がフォローしている人
  has_many :followers, through: :of_relationships, source: :follower
  # 自分をフォローしている人
  has_many :followings, through: :relationships, source: :followed
  # フォローする/される関係を示すのはrelationshipsテーブルだからイメージてきには
  # relationshipsテーブルを経由して、usersテーブルを参照する(中間テーブル)
  # source(スルー)は、あるリレーションを通して実現する

  validates :name, uniqueness: true, length: {minimum: 2, maximum: 20 }
  validates :introduction, length: {maximum: 50 }

  # フォロー機能
  def follow(user_id)
      relationships.create(followed_id: user_id)
      # createメソッドはnewとsaveを合わせた挙動
      # relationship = relationships.new(followed_id: user_id)
      # relationship.save
      # 上記と同様の意味
  end

  def unfollow(user_id)
      relationships.find_by(followed_id: user_id).destroy
      # いいねと同じように、ユーザAがユーザBに対して複数個のフォローを作成することはなく、
      # ユーザBをフォローしている場合、relationshipsテーブルには対応するレコードはただ一つです。
      # そのためfind_byによって1レコードを特定し、destroyメソッドで削除しています。
  end

  def following?(user)
      followings.include?(user)
      # 引数に渡したユーザを、フォローしているかどうかを判定します。
      # include?は対象の配列に引数のものが含まれていればtrue、含まれていなければfalseを返します。
      # @user.followingsは「@userがフォローしているユーザ一覧」ですので、
      # ここに含まれていれば、引数に渡したユーザをフォローしている（true）ことになります。
      # このメソッドは、ビューでフォローする/フォローを外すボタンの表示で用いています。
  end

  # 検索機能
  def self.search(search,word)
    if search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @user = User.where(name:"#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
