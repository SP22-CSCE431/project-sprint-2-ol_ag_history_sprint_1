class Event < ApplicationRecord
    has_many :attendance
    has_many :due
    validates :name, :location, :time, presence: true
end
