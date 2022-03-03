class Attendance < ApplicationRecord
    belongs_to :event 
    belongs_to :member 
    validates :attended, :rsvp, inclusion: [true, false]
end
