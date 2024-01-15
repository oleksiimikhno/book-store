require 'ffaker'

STUB = 'Just the text to fill in the required number of characters. Just the text to fill in the required number of characters.'

10.times do
  user = User.create(first_name: FFaker::Name.first_name,
                     last_name: FFaker::Name.last_name,
                     email: FFaker::Internet.free_email,
                     password: 'Password123')
  3.times do
    cart = Cart.create(user_id: user.id, status: rand(0..1))

    product = Product.create(
      name: FFaker::Book.title,
      description: FFaker::Book.description,
      meta_title: "genre: #{FFaker::Book.genre}; author: #{FFaker::Book.author}.",
      meta_description: "genre: #{FFaker::Book.genre}; author: #{FFaker::Book.author}; #{STUB}.",
      quantity: 100,
      price: 1000
    )

    CartItem.create(cart_id: cart.id, product_id: product.id, quantity: 3, price: product.price)
  end
end
