class Api::V1::PassesController < ApplicationController
  respond_to :json

  def index
    respond_with Pass.all
  end

  def show
    respond_with Pass.find(params[:id])
  end

  def create 
    pass = Screening.passes.build(pass_params)
    if pass.save
      render json: pass, status: 201, location: [:api, pass]
    else
      render json: { errors: pass.errors }, status: 422
    end
  end

  def update
    pass = Screening.passes.find(params[:id])
    if pass.update(pass_params)
      render json: pass, status: 200, location: [:api, pass]
    else
      render json: { errors: pass.errors }, status: 422
    end
  end

  def destroy
    pass = Screening.passes.find(params[:id])
    pass.destroy
    head 204
  end

private
  def pass_params 
    params.require(:pass).permit(:pass_type_id, :serial_number)
  end
end
