class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles, join_table: 'users_roles'

  has_many :trades
  has_many :login_histories, dependent: :destroy
  has_one  :address, dependent: :destroy

  scope :members, -> {joins(:roles).where(:"roles.name" => 'member')}
  scope :admin, -> {joins(:roles).where(:"roles.name" => 'admin')}

  after_create :set_member, :generate_sms_code
 
  validates_presence_of :first_name, :last_name, :phone_number
  # validates_uniqueness_of :phone_number

  accepts_nested_attributes_for :address

  def is_admin?
    roles.map(&:name).include?('admin')
  end

  def is_member?
    roles.map(&:name).include?('member')
  end

  def set_member
    self.role_ids = Role.find_by_name('member').id
  end

  def generate_sms_code
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    string = (0...4).map { o[rand(o.length)] }.join
    self.sms_code = string
    save
  end
end