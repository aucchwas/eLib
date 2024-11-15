class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all
    @books = Book.order(:title).page(params[:page]).per(15)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: "Book was successfully destroyed."
  end

  def new_books
    @books = Book.where("created_at >= ?", 3.days.ago.utc)
    Rails.logger.debug "Number of books created in the last 3 days: #{@books.count}"
    @books = Book.order(:title).page(params[:page]).per(15)
  end

  def updated_books
    @books = Book.where("updated_at >= ?", 3.days.ago.utc)
    @books = Book.order(:title).page(params[:page]).per(15)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :price, :publisher)
  end
end
