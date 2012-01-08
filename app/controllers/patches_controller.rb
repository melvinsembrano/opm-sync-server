class PatchesController < ApplicationController

  def nearest

  end

  def find
    lat = params[:lat] || 0
    lng = params[:lng] || 0
    size = params[:size] || 10
    radius = params[:radius] || 1
    offset = ((params[:page] || 1).to_int - 1) * size
    @patches = Business.nearest_businesses(lat, lng, radius, offset, size)

    respond_to do |format|
      format.html { render :action => "nearest"}
      format.json { render json: @patches }
    end
  end


end
