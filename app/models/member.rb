class Member < ApplicationRecord
  has_one :lineage
  has_many :due
  has_one :attendance
  validates :fname, :lname, :email, presence: true
  has_one :lineage, dependent: :destroy
end
