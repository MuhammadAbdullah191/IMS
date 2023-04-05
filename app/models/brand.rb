class Brand < ApplicationRecord
	has_many :products

	validates :name, presence: true
  validates :description, presence: true
end
