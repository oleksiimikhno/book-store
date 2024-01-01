require 'ffaker'

10.times do
  user = User.create(first_name: FFaker::Name.first_name,
                     last_name: FFaker::Name.last_name,
                     email: FFaker::Internet.free_email,
                     password: 'Password123')

  Cart.create(user_id: user.id)
  5.times do
    Cart.create(user_id: user.id, status: 1)
  end
end
