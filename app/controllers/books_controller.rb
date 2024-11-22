class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  before_action :set_book, only: %i[show edit update destroy add_to_cart update_quantity remove_from_cart]

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

  def add_to_cart
    cart = current_cart
    book_id = params[:id].to_s
    cart[book_id] ||= 0
    cart[book_id] += 1
    session[:cart] = cart

    respond_to do |format|
      format.html { redirect_to books_path, notice: "Book added to cart." }
      format.turbo_stream
    end
  end

  def update_quantity
    cart = current_cart
    book_id = params[:id].to_s
    quantity = params[:quantity].to_i
    if quantity > 0
      cart[book_id] = quantity
    else
      cart.delete(book_id)
    end
    session[:cart] = cart
    redirect_to cart_path, notice: "Cart updated."
  end

  def remove_from_cart
    cart = current_cart
    book_id = params[:id].to_s
    cart.delete(book_id)
    session[:cart] = cart
    redirect_to cart_path, notice: "Book removed from cart."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :price, :publisher)
  end
end
