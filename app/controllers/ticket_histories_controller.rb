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
    @ticket_history.staff = current_user.staff
  end

  def create
    @ticket_history = TicketHistory.new(ticket_history_params)
    @ticket.state = @ticket_history.state
    @ticket_history.ticket = @ticket
    is_saved = @ticket_history.save
    XTickMailer.ticket_history_created(@ticket_history).deliver if is_saved
    return redirect_to tickets_path, notice: 'Ticket history was successfully created.' if  is_saved
    render action: 'new'
  end

  def customer_link
    @ticket = Ticket.where(link: params[:customer_link]).first
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
