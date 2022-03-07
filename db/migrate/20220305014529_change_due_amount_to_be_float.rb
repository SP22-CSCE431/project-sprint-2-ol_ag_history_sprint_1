class ChangeDueAmountToBeFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :dues, :dueAmount, :float
  end
end
