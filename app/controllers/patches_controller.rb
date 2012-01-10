class PatchesController < ApplicationController

  def nearest

  end

  def find
    @lat = params[:lat] || 0
    @lng = params[:lng] || 0
    @size = params[:size] || 20
    @radius = params[:radius] || 0.3
    @offset = ((params[:page] || 1).to_int - 1) * @size
    @category_id = params[:cat] || 199
    @patches = Business.nearest_businesses(@lat, @lng, @radius, @offset, @size, @category_id)

    respond_to do |format|
      format.html { render :action => "nearest"}
      format.json { render json: @patches.to_json(:only => [:name, :distance, :lng, :lat]) }
    end
  end


end
