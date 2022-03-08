# frozen_string_literal: true

class Event < ApplicationRecord
    has_many :attendance, dependent: :destroy
    has_many :due, dependent: :destroy
    validates :name, :description, :location, :start_time, :end_time, presence: true
<<<<<<< HEAD
    validate :start_greater_equal, :inFuture

    def start_greater_equal
        if start_time == end_time
            errors.add(:start_time, 'must be before end time')
            errors.add(:end_time, 'must be after start time')
        end
        if start_time > end_time
            errors.add(:start_time, 'must be before end time')
            errors.add(:end_time, 'must be after start time')
        end
    end

    def inFuture
        if start_time < DateTime.current-6.hours
            errors.add(:start_time, 'must not have already passed')
        end
        if end_time < DateTime.current-6.hours
            errors.add(:end_time, 'must not have already passed')
        end
    end
=======
>>>>>>> test
end
