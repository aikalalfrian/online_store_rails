class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :product_must_be_available
  before_validation :set_user

  private

  def set_user
    self.user = Current.user if Current.user.present?
  end

  def product_must_be_available
    product = Product.find_by(id: product_id)
    if product.nil?
      errors.add(:product_id, "must be a valid product")
    elsif quantity.present? && product.stock_quantity < quantity
      errors.add(:quantity, "exceeds available stock")
    end
  end
end
