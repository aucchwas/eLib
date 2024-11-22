class CartsController < ApplicationController
  def show
    @cart_items = current_cart.map do |book_id, quantity|
      book = Book.find(book_id)
      { book: book, quantity: quantity }
    end
  end
end
