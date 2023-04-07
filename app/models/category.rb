class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
end
