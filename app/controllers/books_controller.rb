class BooksController < ApplicationController
  
  def index
    @books = Book.order(:position)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @count = Book.count
    @book = Book.new(position: @count + 1)
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to books_path
    else
      flash[:notice] = @book.errors.full_messages.join(", ")
      redirect_to new_book_path
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully edited."
      redirect_to book_path(@book)
    else
      render('edit')
    end
  end

  def delete
    @book = Book.find(params[:id])
  
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was successfully deleted."
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(
      :title, 
      :position,
      :author,
      :price,
      :published_date)
  end
  
end
