class ScreeningSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :title, :location, :location_name, :time_date, :terms_n_conditions, :created_at, :updated_at, :bg_img_file_name, :bg_img_content_type, :bg_img_file_size, :bg_img_updated_at, :bg_img_x_file_name, :bg_img_x_content_type, :bg_img_x_file_size, :bg_img_x_updated_at, :icon_img_file_name, :icon_img_content_type, :icon_img_file_size, :icon_img_updated_at, :icon_img_x_file_name, :icon_img_x_content_type, :icon_img_x_file_size, :icon_img_x_updated_at, :logo_img_file_name, :logo_img_content_type, :logo_img_file_size, :logo_img_updated_at, :logo_img_x_file_name, :logo_img_x_content_type, :logo_img_x_file_size, :logo_img_x_updated_at, :tn_img_file_name, :tn_img_content_type, :tn_img_file_size, :tn_img_updated_at, :tn_img_x_file_name, :tn_img_x_content_type, :tn_img_x_file_size, :tn_img_x_updated_at, :max_tickets_to_issue, :parse_screening_object_id
  has_many :passes
end
