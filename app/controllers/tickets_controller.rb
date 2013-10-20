class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:new, :create, :index]

  def index
    #@tickets = Ticket.all if current_user.present?
  end

  def show
  end

  def new
    @ticket = Ticket.new
    email = current_user.present? ? current_user.email : ''
    @ticket.customer = Customer.new(email: email)
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.state = Ticket::State.hash_values[:waiting_for_staff]

    link = ''
    begin
      link = "customer#{rand(999999999999)}"
    end while (Ticket.where(link: link).length != 0)
    @ticket.link = link

    is_saved = @ticket.save

    XTickMailer.ticket_created(@ticket).deliver if is_saved
    return redirect_to tickets_url, notice: 'Ticket was successfully created. Check your email.' if is_saved
    render action: :new
  end

  def update
    return redirect_to tickets_url notice: 'Ticket was successfully updated.' if @ticket.update(ticket_params)
    render action: :edit
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:subject, :body, customer_attributes: [:name, :email])
  end

end
