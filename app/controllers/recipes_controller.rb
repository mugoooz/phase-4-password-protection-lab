class RecipesController < ApplicationController
    before_action :require_login, only: [:index, :create]

    def index
      recipes = Recipe.all
      render json: recipes, include: :user, status: :ok
    end
  
    def create
      recipe = current_user.recipes.build(recipe_params)
      if recipe.save
        render json: recipe, include: :user, status: :created
      else
        render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def recipe_params
      params.require(:recipe).permit(:title, :instructions, :minutes_to_complete)
    end
  
    def require_login
      unless session[:user_id]
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end

end
