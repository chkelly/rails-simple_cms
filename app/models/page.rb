class Page < ActiveRecord::Base

  validates_presence_of :name
  validates_length_of :name, :maximum => 100
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  validates_uniqueness_of :permalink
  
  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
end
