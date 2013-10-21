class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:new, :create, :index]

  def index
  end

  def show
  end

  def new
    @ticket = Ticket.new
    @ticket.auto_set_email_address current_user
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.init_before_create
    XTickMailer.ticket_created(@ticket).deliver
    return redirect_to tickets_url, notice: 'Ticket was successfully created. Check your email.' if @ticket.save
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
