class Ticket < ActiveRecord::Base

  belongs_to :customer

  accepts_nested_attributes_for :customer

  has_many :ticket_histories

  scope :created, -> { where(state: State::hash_values[:waiting_for_staff]) }
  scope :open, -> { where(state: State::hash_values[:waiting_for_customer]) }
  scope :hold, -> { where(state: State::hash_values[:on_hold]) }
  scope :closed, -> { where(state: State::hash_values[:completed]).where(state: State::hash_values[:canceled])  }

  module State

    def self.hash_values
      { waiting_for_staff: 'Waiting for staff',
       waiting_for_customer: 'Waiting for customer',
       on_hold: 'On hold',
       canceled: 'Canceled',
       completed: 'Completed' }
    end

  end

end
