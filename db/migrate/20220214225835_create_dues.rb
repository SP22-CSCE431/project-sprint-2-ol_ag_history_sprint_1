class CreateDues < ActiveRecord::Migration[6.1]
  def change
    create_table :dues do |t|
      t.integer :member_id
      t.integer :event_id
      t.integer :dueAmount

      t.timestamps
    end
  end
end
