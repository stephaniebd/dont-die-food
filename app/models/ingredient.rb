class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :pantry_items
  has_many :recipes, through: :recipe_ingredients
  has_many :user_owned_ingredients

  validates :name, presence: true, uniqueness: true
  validates :photo, presence: true
end
