class CreateLineages < ActiveRecord::Migration[6.1]
  def change
    create_table :lineages do |t|
      t.integer :member_id
      t.integer :father
      t.integer :son

      t.timestamps
    end
  end
end
