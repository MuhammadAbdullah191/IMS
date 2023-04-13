# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
end
