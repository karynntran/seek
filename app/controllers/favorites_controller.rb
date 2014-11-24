class FavoritesController < ApplicationController

  def check_favorites
    links = current_user.favorites.map { |favorite| favorite[:link] }
    respond_to do |format|
      if current_user && current_user.favorites && links.include?(params[:url])

        format.json { render json: { status: "true" } }
      else
        format.json { render json: { status: "false" } }
      end
    end
  end

  def add_favorites
    respond_to do |format|
      favorite = Favorite.create({user_id: current_user.id, link: params[:favorite]})
      current_user.favorites << favorite
      format.json { render json: { status: "OK" } }
    end
  end

  def delete_favorites
    respond_to do |format|
      favorite = Favorite.where({user_id: current_user.id, link: params[:remove]})
      Favorite.destroy(favorite)
      format.json {render json: { status: "OK"} }
    end
  end
end

