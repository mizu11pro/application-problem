class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # redirect_to request.referer
    # 非同期通信の際はredirect_toやrenderは不要
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(user_id: current_user, book_id: @book.id)
    # current_userのfavorutesの中から(user_idカラムのcurrent_user)と、(book_idカラムの@book.id)と一致するものを取得
    favorite.destroy
    # redirect_to request.referer
    # 非同期通信の際はredirect_toやrenderは不要
  end

end
