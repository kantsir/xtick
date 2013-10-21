class Ticket < ActiveRecord::Base

  belongs_to :customer

  accepts_nested_attributes_for :customer

  has_many :ticket_histories

  scope :created, -> { where(state: State::hash_values[:waiting_for_staff]) }
  scope :open, -> { where(state: State::hash_values[:waiting_for_customer]) }
  scope :hold, -> { where(state: State::hash_values[:on_hold]) }
  scope :closed, -> { where(state: [State::hash_values[:completed], State::hash_values[:canceled]]) }

  module State

    def self.hash_values
      {waiting_for_staff: 'Waiting for staff',
       waiting_for_customer: 'Waiting for customer',
       on_hold: 'On hold',
       canceled: 'Canceled',
       completed: 'Completed'}
    end

  end


  def self.search(text)
    tickets=Ticket.arel_table
    subject_matches = match_search_params(tickets, :subject, text)
    body_matches = match_search_params(tickets, :body, text)
    link_matches = match_search_params(tickets, :link, text)
    Ticket.where(body_matches.or(link_matches.or(subject_matches)))
  end

  def init_before_create
    init_state
    generate_unique_customer_link
  end

  def self.get_by_unique_customer_link(link)
    Ticket.where(link: link).first
  end

  def auto_set_email_address(user)
    email = user.present? ? user.email : ''
    self.customer = Customer.new(email: email)
  end

  private
  def self.match_search_params(arel_table, column, search)
    arel_table[column].matches("%#{search}%")
  end

  def init_state
    self.state = State.hash_values[:waiting_for_staff]
  end

  def generate_unique_customer_link
    self.link = generate_code
  end

  def generate_code
    value = ''
    3.times{value  << (65 + rand(25)).chr}
    value << '-'
    6.times{value  << (48+ rand(10)).chr}
    generate_code if Ticket.where(link: value).length != 0
    value
  end

end
