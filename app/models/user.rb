class User < ActiveRecord::Base
  include Authenticatable
  include Identifiable

  attr_accessor :password
  validates :password, :password_confirmation, presence: true, on: :create
  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true, on: :create

  has_many :time_logs
  has_many :assignments

  before_create :encrypt_password

  def admin?
    role == "admin" ? true : false
  end

  def promote!
    tap{update_attributes(role: "admin")}
  end
end
