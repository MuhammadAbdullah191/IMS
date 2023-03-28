class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :supplier

  validates :name, presence: true
  validates :stock, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
