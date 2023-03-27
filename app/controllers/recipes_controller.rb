class RecipesController < ApplicationController
  #  before_action :authenticate_user!
   
   def index
    if recipes = Recipe.all.includes(:user)
        render json: recipes
    else
        render json: { error: 'You need to log in to view recipes' }, status: :unauthorized
    end
  end


  def create
    recipe = Recipe.create(recipe_params)
    if recipe.save
      render json: recipe, status: :created
    else
      render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end


end
