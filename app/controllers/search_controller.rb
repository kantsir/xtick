class SearchController < ApplicationController

   def search
      search = params[:search]
      tickets=Ticket.arel_table

      subject_matches = match_search_params tickets, :subject, search
      body_matches = match_search_params tickets, :body, search
      link_matches = match_search_params tickets, :link, search

      @tickets = Ticket.where(body_matches.or(link_matches.or(subject_matches)))

      render 'tickets/index'
   end

  def match_search_params(arel_table, column, search)
    arel_table[column].matches("%#{search}%")
  end

end