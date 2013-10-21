class TicketHistory < ActiveRecord::Base

  belongs_to :staff
  belongs_to :ticket

  accepts_nested_attributes_for :ticket

  def set_staff(user)
    self.staff = user.staff
  end

  def set_ticket(ticket)
    ticket.state = self.state
    self.ticket = ticket
  end

  def update_with_state(params)
    self.ticket.state = params[:state]
    self.update params
    self.save
  end

end
