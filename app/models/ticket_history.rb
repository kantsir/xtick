class TicketHistory < ActiveRecord::Base

  belongs_to :staff
  belongs_to :ticket

  accepts_nested_attributes_for :ticket

end
