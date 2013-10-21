class Customer < ActiveRecord::Base

  has_many :tickets

  validates :email, :name, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, length: { minimum: 3, maximum: 50 }

end
