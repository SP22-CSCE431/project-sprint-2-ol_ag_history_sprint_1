# frozen_string_literal: true

class Member < ApplicationRecord
  validates :fname, :lname, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_one :lineage, dependent: :destroy
end
