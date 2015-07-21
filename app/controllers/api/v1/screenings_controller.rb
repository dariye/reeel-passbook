class Api::V1::ScreeningsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :update, :delete]
  before_filter :verified_request?
  respond_to :json

  def index
    respond_with Screening.all
  end

  def show
    respond_with Screening.filter_by_parse_screening_id(params[:object_id])
  end

  def create
    screening = Screening.new(screening_params)
    logger.debug screening 
    if screening.save
      render json: screening, status: 201, location: [:api, screening]
    else
      render json: { errors: screening.errors }, status: 422
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
    params.require(:screening).permit(:title, :location, :time_date, :terms_n_conditions, :parse_screening_object_id, :location_name)
  end

  def verified_request?
    if request.content_type == 'application/json'
      true
    else
      super()
    end
  end
end
