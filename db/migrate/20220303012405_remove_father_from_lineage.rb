class RemoveFatherFromLineage < ActiveRecord::Migration[6.1]
  def change
    remove_column :lineages, :big, :integer
    remove_column :lineages, :little, :integer
    add_column :lineages, :father, :integer
    add_column :lineages, :son, :integer
  end
end
