class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
