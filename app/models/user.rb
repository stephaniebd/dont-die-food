class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pantry_items

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
            format: { with: /\w+@\w+\.[a-z]{2,4}\z/, message: "Please enter a valid email address"}
  validates :encrypted_password, presence: true, length: { minimum: 6 }
end
