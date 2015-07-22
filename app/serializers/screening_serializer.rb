class ScreeningSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :title, :location, :location_name, :time_date, :terms_n_conditions, :created_at, :updated_at, :parse_id
  has_many :passes
end
