require 'ffaker'

categories = []

5.times do
  categories << FFaker::Book.genre
end

categories.uniq.each do |e|
  Category.create!(name: e,
                   description: 'description',
                   meta_title: FFaker::Book::description[0, 30],
                   meta_description: FFaker::Book::description[0, 60])
end

10.times do
  user = User.create!(first_name: FFaker::Name.first_name,
                      last_name: FFaker::Name.last_name,
                      email: FFaker::Internet.free_email,
                      password: 'Password123')
  3.times do
    cart = Cart.create!(user_id: user.id, status: rand(0..1))

    product = Product.create!(
      name: FFaker::Book.title,
      description: FFaker::Book.description,
      meta_title: "genre: #{FFaker::Book.genre}; author: #{FFaker::Book.author}.",
      meta_description: "genre: #{FFaker::Book.genre}; author: #{FFaker::Book.author}; #{FFaker::Book::description[0, 30]}.",
      quantity: 100,
      price: 1000,
      category_id: Category.all.sample.id
    )

    CartItem.create!(cart_id: cart.id, product_id: product.id, quantity: 3, price: product.price)
  end
end
