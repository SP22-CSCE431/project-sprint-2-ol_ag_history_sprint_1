class Lineage < ApplicationRecord
  validates :member_id, presence: true
  belongs_to :member
end
