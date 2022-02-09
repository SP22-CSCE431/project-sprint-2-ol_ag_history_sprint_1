class CreateLineages < ActiveRecord::Migration[6.1]
  def change
    create_table :lineages do |t|
      t.integer :memberID
      t.integer :big
      t.integer :little

      t.timestamps
    end
  end
end
