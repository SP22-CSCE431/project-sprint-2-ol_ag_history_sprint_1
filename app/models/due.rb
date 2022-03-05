include ActionView::Helpers::UrlHelper
class Due < ApplicationRecord
    belongs_to :member
    belongs_to :event
    validates :dueAmount, presence: true
    validates :paid, inclusion: [true, false]

    def due_mail
      ar = ","
      Due.select("Distinct(member_id), dues.member_id").where(paid: 0).each do |d|
        ar += Member.where(id: d.member_id).first.email
        ar += ','
      end
      mail_to(nil, "Send Due Reminder Email", {bcc: ar, subject: "Ol'Ags Dues Reminders"})
    end
end
