class XTickMailer < ActionMailer::Base
  default from: 'admin@xtick.com'

  def ticket_created(ticket)
    @ticket = ticket
    @url = XTick::Application::XTickDomain::CURRENT_DOMAIN + "/ticket/#{@ticket.link}"
    mail(to: @ticket.customer.email, subject: '[XTick]: Ticked posted')
  end

  def ticket_history_created(ticket_history)
    @ticket = ticket_history.ticket
    @url = XTick::Application::XTickDomain::CURRENT_DOMAIN + "/ticket/#{@ticket.link}"
    mail(to: @ticket.customer.email, subject: '[XTick]: Ticked updated')
  end


end
