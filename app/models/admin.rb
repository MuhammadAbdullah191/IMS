# frozen_string_literal: true

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum role: { Admin: 0, Cashier: 1 }
  validates :role, presence: true
  validates :username, presence: true, length: { minimum: 5, maximum: 20 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :phone,
            format: { with: /\A((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})\z/,
                      message: 'number is invalid. Please enter again' }
end
