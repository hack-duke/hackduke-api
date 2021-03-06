class Event < ApplicationRecord
  belongs_to :semester
  has_many :participants
  has_many :judges
  has_many :speakers
  has_many :sponsors
  has_many :volunteers
  has_many :mentors
  has_many :teams
  enum event_type: [:code_for_good, :education_series, :puzzle_hacks, :design_con]
end
