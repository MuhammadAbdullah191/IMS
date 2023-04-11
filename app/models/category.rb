class Category < ApplicationRecord
  has_and_belongs_to_many :products
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 50 }
end
