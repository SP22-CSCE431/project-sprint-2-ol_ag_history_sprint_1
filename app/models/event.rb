# frozen_string_literal: true

class Event < ApplicationRecord
    has_many :attendance, dependent: :destroy
    has_many :due, dependent: :destroy
    validates :name, :location, :time, presence: true
end
