class Due < ApplicationRecord
    belongs_to :member
    belongs_to :event
    validates :dueAmount, presence: true
    validates :paid, inclusion: [true, false]
end
