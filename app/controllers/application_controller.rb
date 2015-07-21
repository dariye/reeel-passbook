require "application_responder"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  skip_before_action :verify_authenticity_token, if: :json_request?
  self.responder = ApplicationResponder
  respond_to :json
protected
  def json_request?
    request.format.json?
  end
end
