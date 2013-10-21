class TicketHistoriesController < ApplicationController
  before_action :set_ticket_history, only: [:show, :edit]
  before_action :set_ticket, except: [:customer_link]

  before_filter :authenticate_user!, except: [:customer_link]

  def index
    @ticket_histories = @ticket.ticket_histories
  end

  def show
  end

  def new
    @ticket_history = TicketHistory.new
    @ticket_history.set_staff current_user
  end

  def create
    @ticket_history = TicketHistory.new(ticket_history_params)
    @ticket_history.set_ticket @ticket

    XTickMailer.ticket_history_created(@ticket_history).deliver
    return redirect_to tickets_path, notice: 'Ticket history was successfully created.' if  @ticket_history.save
    render action: 'new'
  end

  def customer_link
    @ticket = Ticket.get_by_unique_customer_link(params[:customer_link])

    return redirect_to tickets_path if @ticket.nil?
    @ticket_histories = @ticket.ticket_histories
    render 'ticket_histories/index'
  end

  private
  def set_ticket_history
    @ticket_history = TicketHistory.find(params[:id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def ticket_history_params
    params.require(:ticket_history).permit(:state, :resolution, :staff_id)
  end
end
