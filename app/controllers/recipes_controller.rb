
class RecipesController < ApplicationController
  def index
    @recipes = Recipe.render_all
  end

  def show
    @recipe = Recipe.new(params[:id]).render
  end
end
