require "#{Rails.root}/lib/passbook_helpers/utils.rb"

class Api::V1::PassesController < ApplicationController
  include PassbookHelpers::Utils
  respond_to :json
  # skip_before_action :verify_authenticity_token # <-- find another way
  def index
    respond_with Pass.search(params)
  end

  def show
    pass = Pass.find(params[:id])
    pass_path = ENV['passes_folder_path'] + "/passes/#{pass.id}"
    pass_json = File.read(pass_path + "/pass.json")
    pkpass = Passbook::PKPass.new pass_json
    files = []
    Dir.foreach(pass_path) do |file|
      next if file == '.' or file == '..' or file == '.DS_Store'
      files << File.join(pass_path, file) 
    end
    pkpass.addFiles files
    send_file(pkpass.file.path, type: 'application/vnd.apple.pkpass', disposition: 'attachment', filename: 'pass.pkpass', status: 201, location: [:api, pass])
  end

  def create
    screening = Screening.find(params[:pass][:screening_id])
    pass = screening.passes.build(pass_params)
    if pass.save
      render json: pass, status: 201, location: [:api, pass]
    else
      render json: { errors: pass.errors }, status: 422
    end
  end

  def update
    screening = Screening.find(params[:pass][:screening_id])
    pass = screening.passes.build(pass_params)
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
    params.require(:pass).permit(:pass_type_id, :serial_number, :screening_id, :user_id, :number_of_seats)
  end
end
