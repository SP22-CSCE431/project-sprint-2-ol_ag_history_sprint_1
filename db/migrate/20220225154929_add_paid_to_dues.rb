class AddPaidToDues < ActiveRecord::Migration[6.1]
  def change
    add_column :dues, :paid, :boolean
  end
end
