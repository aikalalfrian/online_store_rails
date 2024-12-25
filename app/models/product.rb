class Product < ApplicationRecord
  has_many :carts, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :ensure_non_negative_stock
  before_validation :set_user

  private

  def ensure_non_negative_stock
    if stock_quantity < 0
      errors.add(:stock_quantity, "cannot be negative")
      throw(:abort)
    end
  end

  def set_user
    self.user = Current.user if Current.user.present?
  end
end
