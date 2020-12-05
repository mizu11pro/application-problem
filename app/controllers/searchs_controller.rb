class SearchsController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]

    if @range == '1'
      @user = User.search(search,word)
      # wordで検索内容を持ってきている
    else
      @book = Book.search(search,word)
    end
  end
  # 検索するとredirect設定しなくてもserchコントローラーに飛ぶ？

end
