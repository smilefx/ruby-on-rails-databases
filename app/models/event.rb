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
    @months = ["Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"]
    self.date.strftime("%d. ") + @months[self.date.month - 1] + self.date.strftime(" %Y")
  end

  def named_date_day
    @days = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"]
    @days[self.date.wday] + ", " + self.named_date
  end

  def named_time
    self.time.strftime("%H:%M") + " Uhr"
  end
end
