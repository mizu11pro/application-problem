class SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    @word = params[:word]

    if @range == '1'
      # range 1 = userを選択すると検索したワードを@userに代入
      @user = User.search(search,@word)
      # ここの定義はuser.rb(model)で定義する
      # wordで検索内容を持ってきている
    else
      @book = Book.search(search,@word)
      # ここの定義はbook.rbで定義する
    end
  end
  # 検索するとredirect設定しなくてもserchコントローラーに飛ぶ？

end
