class AddDefaultUser < ActiveRecord::Migration[8.0]
  def up
    User.create!(
      email: 'default@kiwil.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  def down
    User.find_by(email: 'default@kiwil.com')&.destroy
  end
end
