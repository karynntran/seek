class FavoritesController < ApplicationController

  def check_favorites
    respond_to do |format|
      if current_user && current_user.favorites && current_user.favorites.include?(params[:url])
        format.json { render json: { status: "true" } }
      else
        format.json { render json: { status: "false" } }
      end
    end
  end

  def add_favorites
    favorite = Favorite.create({user_id: current_user.id, link: params[:favorite]})
    current_user.favorites << favorite
  end
end
