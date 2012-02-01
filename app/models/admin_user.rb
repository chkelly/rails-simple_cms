require 'digest/sha1'
class AdminUser < ActiveRecord::Base
  
  attr_accessor :password
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  #Standard Validations
  #validates_presence_of :first_name
  #validates_length_of :first_name, :maximum => 25
  #validates_presence_of :last_name
  #validates_length_of :last_name, :maximum => 50
  #validates_presence_of :username
  #validates_length_of :username, :within => 5..25
  #validates_presence_of :email
  #validates_length_of :email, :maximum => 100
  #validates_format_of :email, :with => EMAIL_REGEX
  #validates_confirmation_of :email
  #has_and_belongs_to_many :pages
  #has_many :section_edits
  #has_many :sections, :through => :section_edits
  
  #only on create
  validates_length_of :password, :within => 8..25, :on => :create
  
  
  # new sexy validations
  validates :first_name, :presence => true, :length => { :maximum => 24 }
  validates :last_name, :presence => true, :length => { :maximum => 50 }
  validates :username, :length => { :within => 6..25 }, :uniqueness => true
  validates :email, :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX, :confirmation => true
  
  before_save :create_hashed_password
  after_save :clear_password
  
  scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
  
  attr_protected :hashed_password, :salt
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
  def self.authenticate(username="", password="")
    user = AdminUser.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end
  
  def password_match?(password="")
    hashed_password == AdminUser.hash_with_salt(password, salt)
  end
  
  private
  
  def create_hashed_password
    #Whenever :password value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = AdminUser.make_salt(username) if salt.blank?
      self.hashed_password = AdminUser.hash_with_salt(password, salt)
    end
  end
  
  def clear_password
    #for security and b/c hashing is not needed
    self.password = nil
  end
  
end
