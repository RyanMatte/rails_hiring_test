class PollingLocationsController < ApplicationController
  before_action :set_riding
  before_action :set_polling_location, only: [:edit, :update]

  def edit
  end

  def update
    if @polling_location.update(polling_location_params)
      flash.now[:notice] = "#{@polling_location.title} was successfully updated."
      respond_to do |format|
        format.html { redirect_to riding_path(@riding)}
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_riding
    @riding = Riding.find(params[:riding_id])
  end

  def set_polling_location
    @polling_location = @riding.polling_locations.find(params[:id])
  end

  def polling_location_params
    params.require(:polling_location).permit(:title, :address, :city, :postal_code)
  end
end