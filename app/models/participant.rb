class Participant < ApplicationRecord
  belongs_to :event
  belongs_to :person
  enum status: [:accepted, :rejected, :confirmed, :waitlisted, :attended]
end

