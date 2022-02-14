class Event < ApplicationRecord
    validates :eventID, :name, :location, :start_time, :end_time, presence: true
end
