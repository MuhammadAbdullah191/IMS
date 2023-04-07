class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
