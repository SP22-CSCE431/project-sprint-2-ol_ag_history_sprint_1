# frozen_string_literal: true

class Member < ApplicationRecord
  has_one :lineage
  has_many :due
  has_one :attendance
  validates :fname, :lname, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_one :lineage, dependent: :destroy
  def full_name
    "#{fname} #{lname}"
  end
end
