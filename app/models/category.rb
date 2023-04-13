# frozen_string_literal: true

class Category < ApplicationRecord
  has_and_belongs_to_many :products
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 20 }
  validates :description, presence: true, length: { minimum: 5, maximum: 200 }
  validates :image, content_type: %r{\Aimage/.*\z}
end
