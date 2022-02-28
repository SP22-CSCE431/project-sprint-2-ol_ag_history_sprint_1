# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, :location, :time, presence: true
end
