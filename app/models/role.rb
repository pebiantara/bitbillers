class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: 'users_roles'
  validates :name, uniqueness: true

  scope :member, -> { where(name: 'member').first }

  class << self
    def default_role
      Role.create([{name: 'admin'}, {name: 'member'}])
    end
  end
end