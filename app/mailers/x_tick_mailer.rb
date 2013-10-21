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

  def user_access_change(staff, is_approved)
    @staff = staff
    @url = XTick::Application::XTickDomain::CURRENT_DOMAIN + "/staffs/#{@staff.id}/edit"

    return if @staff.approved == is_approved

    @access = is_approved
    mail(to: @staff.user.email, subject: '[XTick]: Access changed')
  end


end
