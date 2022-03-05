class AddRsvpToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :RSVP, :string
  end
end
