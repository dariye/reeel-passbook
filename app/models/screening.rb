class Screening < ActiveRecord::Base
  validates :title, :location, :time_date, :terms_n_conditions, :location_name, presence: true 
  validates :parse_id, presence: true
   
  has_many :passes, dependent: :destroy
  has_many :users, through: :passes
  
  # Filter by -> screeningDate
  scope :filter_by_screening_date, lambda { 
    order(:time_date)
  }
  # Filter by -> created
  scope :recent, lambda {
    order(:updated_at)
  }
  
  # Filter by -> parse_object_id
  scope :filter_by_parse_id, lambda { |id|
    where("parse_id = ?", id)
  }

  def self.search(params = {})
    screenings = params[:screening_ids].present? ? Screening.find(params[:screening_ids]) : Screening.all
    screenings = screening.filter_by_parse_id(params[:object_id]) if params[:object_id]
    screenings
  end
end
