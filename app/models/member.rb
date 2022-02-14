class Member < ApplicationRecord
  validates :fname, :lname, :email, presence: true
  has_one :lineage, dependent: :destroy
end
