class Store < ActiveRecord::Base
  extend FriendlyId
  require 'bcrypt'
  friendly_id :name, use: :slugged
  attr_accessor :password, :password_hash

  validates_presence_of :name
  validates_uniqueness_of :name, :slug
  validate :password_format

  before_save :encryption_password

  def password_format
    if !self.new_record? && !password.present?
      return
    end
    if self.new_record? && !password.present?
      self.errors.add :password, 'Cant be blank.'
    end
    unless password.numeric?
      self.errors.add :password, 'Only numeric allowed.'
    end
  end

  def encryption_password
    if !self.new_record? && !password.present?
      return
    end
    self.password_hash = self.password
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  def password_hash
    if self.encrypted_password
      BCrypt::Password.new(self.encrypted_password)
    end
  end

  def password_hash=(new_password)
    @password_hash = BCrypt::Password.create(new_password)
    self.encrypted_password = @password_hash
  end

  def authenticate(pass)
    self.password_hash == pass
  end

  def url
    host = if Rails.env.eql?('development')
      "http://localhost:3000/device/stores/#{self.friendly_id}"
    else
      "http://104.236.38.53/device/stores/#{self.friendly_id}"
    end
  end
end