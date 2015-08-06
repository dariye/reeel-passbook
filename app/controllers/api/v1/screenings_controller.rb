class Api::V1::ScreeningsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create, :update]
  respond_to :json
  def index
    respond_with Screening.search(params)
  end

  def show
    respond_with Screening.find(params[:id])
  end

  def create
    screening = Screening.new(screening_params)
    if screening.save
      render json: screening, status: 201, location: [:api, screening]
    else
      render json: { errors: screening.errors.full_messages }, status: 422
    end
  end

  def update
    screening = Screening.find(params[:id])
    if screening.update(screening_params)
      render json: screening, status: 200, location: [:api, screening]
     else
      render json: { errors: screening.errors }, status: 422
    end
  end

  def destroy
    screening = Screening.find(params[:id])
    screening.destroy
    head 204
  end

private
  def screening_params
    params.require(:screening).permit(:title, :location, :time_date, :terms_n_conditions, :location_name, :parseid)
  end
end
