class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  has_many :passes, dependent: :destroy
  has_many :screenings, through: :passes
  
  # Filter -> email

  scope :filter_by_email, lambda { |email|
    where("lower(email) LIKE ?", "%#{email.downcase}%")
  }

  def self.search(params = {})
    users = params[:user_ids].present? ? User.find(params[:user_ids]) : User.all
    users = users.filter_by_email(params[:email]) if params[:email]
    users
  end
  
end
