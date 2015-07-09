class User < ActiveRecord::Base
  validates :name, :email, uniqueness: true, presence: true
end
