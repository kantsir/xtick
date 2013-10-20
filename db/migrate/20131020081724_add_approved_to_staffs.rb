class AddApprovedToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :approved, :boolean, default: false
  end
end
