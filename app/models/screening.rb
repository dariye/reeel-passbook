class Screening < ActiveRecord::Base
  validates :title, :location, :time_date, :terms_n_conditions, :location_name, presence: true 
  validates :parse_screening_object_id, presence: true
  validates :max_tickets_to_issue, numericality: { greater_than_or_equal_to: 1 }, presence: true
   
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
  scope :filter_by_parse_screening_id, lambda { |id|
    where("parse_screening_object_id = ?", id)
  }
end
