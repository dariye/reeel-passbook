class User < ActiveRecord::Base
  validate :name, presence: true
  validates :email, uniqueness: true, presence: true
end
