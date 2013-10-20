class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.belongs_to :user
      t.string :name
      t.timestamps
    end
  end
end
