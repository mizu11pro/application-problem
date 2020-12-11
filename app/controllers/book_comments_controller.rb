class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    # comment = PostComment.new(post_comment_params)
    # comment.user_id = current_user.id
    # この記述と変わりなし
    @book_comment.book_id = @book.id
    @book_comment.save
    # redirect_to book_path(@book)
    # 非同期通信の際、消す
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find(params[:id])
     if @book_comment.user != current_user
         redirect_to user_path(@user)
     end
    @book_comment.destroy
    # redirect_to book_path(@book)
    # 非同期通信
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
