class Book < ApplicationRecord
  belongs_to :user
 has_many :book_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200 }

    # いいね機能
  def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    #  引数で渡されたユーザidがfavoritesテーブル内に存在(exists?)するかどうかを調べる
    #  存在していればtrue,なければfalseを返すようにしている
  end

    # 検索機能
  def self.search(search,word)
    if search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
      # 前方一致
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
      # 後方一致
    elsif search == "perfect_match"
      @book = Book.where(title:"#{word}")
      # 完全一致
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
      # 部分一致
    else
      @book = Book.all
    end
  end

end
