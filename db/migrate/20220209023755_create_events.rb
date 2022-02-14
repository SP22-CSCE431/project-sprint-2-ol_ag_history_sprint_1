class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :eventID
      t.string :name
      t.string :location
      t.string :time

      t.timestamps
    end
  end
end
