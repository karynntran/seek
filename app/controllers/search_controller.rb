class SearchController < ApplicationController
  layout 'application'

  def index
    @user = User.new
    render :layout => 'application'
  end

  def autocomplete
    origin = City.where(origin: true).map{ |city| city.name }
    destination = City.all.map{ |city| city.name }

    respond_to do |format|
      format.json { render :json => { origin: origin, destination: destination } }
    end
  end

end
