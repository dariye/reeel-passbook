class Screening < ActiveRecord::Base
  validates :title, :location, :time_date, :terms_n_conditions, :pass_barcode_string, presence: true 
  validates :parse_screening_object_id, uniqueness: true, presence: true
  validates :max_tickets_to_issue, numericality: { greater_than_or_equal_to: 1 }, presence: true
  
  has_many :passes, dependent: :destroy
 
end
