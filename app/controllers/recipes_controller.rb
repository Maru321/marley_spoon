
class RecipesController < ApplicationController
  def index
    @recipes = Recipe.render_all
  end
end
