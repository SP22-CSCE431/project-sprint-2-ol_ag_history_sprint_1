class Lineage < ApplicationRecord
  validates :member_id, uniqueness: {scope: :member_id}
  validates :big, uniqueness: {scope: :big}
  validates :little, uniqueness: {scope: :little}
  validate :check_equality
  validate :At_least_two_nodes

  def check_equality
    errors.add(:little, ": Big and Little can't be the same") if big == little
    errors.add(:member_id, ": Little can't be the same as member id") if little == member_id
    errors.add(:member_id, ": Big can't be the same as member id") if big == member_id
  end

  def At_least_two_nodes
    if (big.blank? && little.blank?)
      errors.add(:Member, ": At last two members need ")
    end
  end

  belongs_to :member
end
