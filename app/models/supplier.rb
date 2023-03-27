class Supplier < ApplicationRecord

	validates :name, presence: true
	validates :email, format: { with: Devise.email_regexp }
	validates :phone,
	format: { with: /\A((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})\z/,
						message: 'number is invalid. Please enter again' }
	validates :address, presence: true
end
