require "#{Rails.root}/lib/passbook_helpers/utils.rb"
class Pass < ActiveRecord::Base
  include PassbookHelpers::Utils

  validates :pass_type_id, :serial_number, :screening_id, :user_id, :number_of_seats, presence: true
  
  belongs_to :screening, inverse_of: :passes
  belongs_to :user, inverse_of: :passes
  before_save :add_auth_token
  after_save :generate_pass_file
  after_update :generate_pass_file
  after_destroy :destroy_pass
  # Filter by -> screening
  scope :filter_by_parse_screening_id, lambda { |id|
    where("parse_screening_object_id = ?", id)
  }

  # Filter by -> serial_number
  scope :filter_by_serial_number, lambda { |serial_number|
    where("serial_number = ?", serial_number)
  }
  
  # Filter by -> pass_type_id
  scope :filter_by_pass_type_id, lambda { |pass_type_id|
    where("pass_type_id = ?", pass_type_id)
  }

  # Filter by -> user_id
  scope :filter_by_user, lambda { |user_id|
    where("user_id = ?", user_id)
  }

  def self.search(params = {})
    passes = params[:pass_ids].present? ? Pass.find(params[:pass_ids]) : Pass.all
    passes = passes.filter_by_parse_screening_id(params[:object_id]) if params[:object_id]
    passes = passes.filter_by_serial_number(params[:serial_number]) if params[:serial_number]
    passes = passes.filter_by_pass_type_id(params[:pass_type_id]) if params[:pass_type_id]
    passes = passes.filter_by_user(params[:user_id]) if params[:user_id]
    passes
  end
private
  def add_auth_token
    self.authentication_token = SecureRandom.hex 
  end

  def generate_pass_file
    configure_pass_folder_path(self.id) 
    modify_pass_json(self, self.screening, self.user) 
  end

  def destroy_pass
    delete_pass_dir(ENV['passes_folder_path'] + "/passes/#{self.id}")
  end
end
