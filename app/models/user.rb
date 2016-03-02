class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles, join_table: 'users_roles'

  has_many :trades
  has_many :login_histories
  has_one  :address

  scope :members, -> {joins(:roles).where(:"roles.name" => 'member')}
  scope :admin, -> {joins(:roles).where(:"roles.name" => 'admin')}

  after_create :set_member
 
  validates_presence_of :first_name, :last_name, :phone_number, :username, :address, :city, :state, :zip_code, :country
  validates_uniqueness_of :phone_number, :username

  accepts_nested_attributes_for :address

  def is_admin?
    roles.map(&:name).include?('admin')
  end

  def is_member?
    roles.map(&:name).include?('member')
  end

  def set_member
    role_ids = Role.find_by_name('member').id
  end
end