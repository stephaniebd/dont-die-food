class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @save_recipe = SavedRecipe.new
    @user_saved_recipe = SavedRecipe.where(user: current_user, recipe: @recipe)

    if user_signed_in?
      @user_owned_ingredients_name = current_user.ingredients.pluck(:name)
    else
      @user_owned_ingredients_name = []
    end
  end

  def search
    if params[:ingredients]
      @search_terms_count = 0
      pantry_item_match = false
      current_user.pantry_items.each do |item|
        if params[:ingredients].include?(item.ingredient_id.to_s)
          pantry_item_match = true
        end
      end

      if pantry_item_match
        @search_terms_count = params[:ingredients].length
      end
    end

  end
end
