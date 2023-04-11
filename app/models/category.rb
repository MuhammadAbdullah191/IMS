class Category < ApplicationRecord
  has_and_belongs_to_many :products
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: {minimum: 5, maximum: 20}
  validates :description, presence: true, length: {minimum: 5, maximum: 50}
  validates :image, content_type: /\Aimage\/.*\z/
end
