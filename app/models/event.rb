# frozen_string_literal: true

class Event < ApplicationRecord
    has_many :attendance
    has_many :due
    validates :name, :description, :location, :start_time, :end_time, presence: true
end
