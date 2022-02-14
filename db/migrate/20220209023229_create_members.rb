class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.integer :memberID
      t.string :fname
      t.string :lname
      t.date :joinDate
      t.date :gradeDate
      t.string :email
      t.string :phoneNumber
      t.string :city
      t.boolean :admin
      t.string :major
      t.string :password

      t.timestamps
    end
  end
end
