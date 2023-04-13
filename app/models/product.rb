# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :suppliers
  belongs_to :brand

  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 20 }
  validates :stock, numericality: { greater_than_or_equal_to: 1 }, on: :create
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { minimum: 5, maximum: 200 }
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :categories, presence: true
  validates :suppliers, presence: true
  validates :image, content_type: %r{\Aimage/.*\z}
end
