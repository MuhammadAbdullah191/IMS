class Supplier < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  has_and_belongs_to_many :products
	
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
  validates :phone,
  format: { with: /\A((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})\z/,
  message: 'number is invalid. Please enter again' }
  validates :address, presence: true, length: {minimum: 5, maximum: 75}
  validates :image, content_type: /\Aimage\/.*\z/
end
