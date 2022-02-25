class Event < ApplicationRecord
    validates :name, :description, :location, :start_time, :end_time, presence: true
end
