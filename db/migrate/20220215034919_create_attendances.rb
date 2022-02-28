class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.integer :member_id
      t.integer :event_id
      t.boolean :attended
      t.boolean :rsvp

      t.timestamps
    end
  end
end
