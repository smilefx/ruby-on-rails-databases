class Event < ApplicationRecord
  belongs_to :course

  # Validations
  VALID_STATUSES = ['Ausstehend', 'In Arbeit', 'Erledigt']
  validates :status, inclusion: { in: VALID_STATUSES }
  validates :title, presence: { message: "Titel muss angegeben werden." }
  validates :date, presence: { message: "Datum muss angegeben werden." }
  validates :time, presence: { message: "Uhrzeit muss angegeben werden." }

  default_scope { order(date: :asc, time: :asc) }

  def named_date
    I18n.l(self.date, format: "%d. %B %Y")
  end

  def named_date_day
    I18n.l(self.date, format: "%A, %d. %B %Y")
  end

  def named_time
    I18n.l(self.time, format: "%H:%M Uhr")
  end
end
