class UsersController < ApplicationController
  before_action :authenticate_user! #各ユーザのURLを検索しても開けないようにしている

  def index
    @book = Book.new
    @users = User.all
  end

  def create
    @user = User.new(book_params)
    @user.save
    redirect_to books_path(@user)
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books #ユーザの持っているbookを代入
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user #ログインしているユーザーでなければredirect処理
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render "edit"
    end
  end

  private

  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
  end
end