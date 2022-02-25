class Event < ApplicationRecord
  validates :name, :location, :time, presence: true
end
