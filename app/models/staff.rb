class Staff < ActiveRecord::Base

  belongs_to :user

  has_many :ticket_histories
  has_many :tickets, through: :ticket_histories


  scope :approved, -> { where(approved: true) }

end
