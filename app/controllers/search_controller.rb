class SearchController < ApplicationController

   def search
      search = params[:search]
      tickets=Ticket.arel_table
      @tickets = Ticket.where(tickets[:body].matches("%#{search}%"))

      render 'tickets/index'
   end

end