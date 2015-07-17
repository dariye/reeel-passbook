class PassSerializer < ActiveModel::Serializer
  attributes :id, :pass_type_id, :serial_number, :screening_id, :created_at, :updated_at, :user_id, :number_of_seats
end
