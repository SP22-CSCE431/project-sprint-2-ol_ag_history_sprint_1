# frozen_string_literal: true

class Event < ApplicationRecord
<<<<<<< HEAD
    has_many :attendance
    has_many :due
    validates :name, :location, :time, presence: true
=======
  validates :name, :location, :time, presence: true
>>>>>>> 28cd43fb4bdeedd37b8a80e4126aebc3c088890f
end
