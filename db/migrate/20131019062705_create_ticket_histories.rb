class CreateTicketHistories < ActiveRecord::Migration
  def change
    create_table :ticket_histories do |t|
      t.belongs_to :staff
      t.belongs_to :ticket
      t.string :state
      t.string :resolution
      t.timestamps
    end
  end
end