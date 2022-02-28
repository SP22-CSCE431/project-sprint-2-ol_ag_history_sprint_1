class RemoveGradeFromMembers < ActiveRecord::Migration[6.1]
  def change
    remove_column :members, :gradeDate, :date
    add_column :members, :gradDate, :date
  end
end
