class SearchController < ApplicationController

  def search
    @tickets = Ticket.search params[:search]
    render 'tickets/index'
  end

end