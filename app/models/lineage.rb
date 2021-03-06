# frozen_string_literal: true
include ActionView::Helpers::UrlHelper
class Lineage < ApplicationRecord
  belongs_to :member
  validates :member_id, uniqueness: { scope: :member_id }
  validates :father, uniqueness: { scope: :father }
  validates :son, uniqueness: { scope: :son }
  validate :check_equality
  validate :at_least_two_nodes

  def check_equality
    errors.add(:son, ": Big and Little can't be the same") if father == son
    errors.add(:member_id, ": Little can't be the same as member id") if son == member_id
    errors.add(:member_id, ": Big can't be the same as member id") if father == member_id
  end
  
  def at_least_two_nodes
    errors.add(:Member, ': At last two members need ') if father.blank? && son.blank?
  end

  def name_check (attribute)
    if Member.where(id: attribute).exists?
      link_to(Member.where(id: attribute).last.fname, Rails.application.routes.url_helpers.member_path(attribute))
    elsif attribute == self.father
      "Head"
    else
      "Tail" 
    end 
  end

  def nil_check (attribute)
    if Member.where(id: attribute).exists?
      {}
    else
      {target: "_blank"}
    end
  end
end
