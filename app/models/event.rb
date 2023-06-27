class Event < ApplicationRecord
    belongs_to :course

    # Validations
    VALID_STATUSES = ['Ausstehend', 'In Arbeit', 'Erledigt']
    validates :status, inclusion: { in: VALID_STATUSES }

    validates :title, presence: { message: "Titel muss angegeben werden." }

    validates :date, presence: { message: "Datum muss angegeben werden." }

    validates :time, presence: { message: "Uhrzeit muss angegeben werden." }

    default_scope { order(date: :asc, time: :asc) }




    # =====  TODO - Beispielaufgabe 4  =====
    #      
    # · Schreibe eine Methode, die das Datum im Format "01. Januar 2024" zurückgibt
    # · I18n.l() kann dabei helfen, das Datum in das gewünschte Format zu bringen (https://api.rubyonrails.org/classes/DateTime.html#method-i-strftime)
    #   · %A = Wochentag
    #   · %d = Tag
    #   · %B = Monat
    #   · %Y = Jahr
    # · Ersetze dafür alles innerhalb der Methode "named_date"

    def named_date
        I18n.l(self.date, format: "%d. %B %Y")
    end

    # ======================================




    def named_date_day
        I18n.l(self.date, format: "%A, ") + self.named_date 
    end

    def named_time
        I18n.l(self.time, format: "%H:%M Uhr")
    end
end
