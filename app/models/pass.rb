class Pass < ActiveRecord::Base
  validates :pass_type_id, :serial_number, presence: true

  belongs_to :screening
end
