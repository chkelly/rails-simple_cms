class Section < ActiveRecord::Base
  
  CONTENT_TYPES = ['text', 'HTML']
  validates_presence_of :name
  validates_length_of :name, :maximum => 100
  validates_inclusion_of :content_type, :in => CONTENT_TYPES, :message => "Must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content
  
  belongs_to :page
  has_many :section_edits
  has_many :editors, :through => :section_edits, :class_name => "AdminUser"
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
end
