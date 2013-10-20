class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :customer
      t.string :subject
      t.string :body
      t.timestamps
    end
  end
end
