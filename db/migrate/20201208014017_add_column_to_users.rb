class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postal_code, :integer
    add_column :users, :prefecture_code, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    # 存在しているテーブル(users)に、新しいカラム(postal_code)を(データ型も)追加する
  end
end