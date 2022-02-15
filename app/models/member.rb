class Member < ApplicationRecord
  has_one :lineage
  has_many :due
  has_one :attendance
end
