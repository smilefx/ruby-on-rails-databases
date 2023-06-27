class Course < ApplicationRecord
    # Assoziation zu Events
    has_many :events, class_name: "Event", dependent: :delete_all

    # Validierungen
    validates :name, presence: { message: "Kursname muss angegeben werden." }

    validates :semester, presence: { message: "Fachsemester muss angegeben werden." }
    validates :semester, numericality: { only_integer: true, message: "Fachsemester muss eine Zahl sein." }

    validates :year, presence: { message: "Semester muss angegeben werden." }
    validates :year, numericality: { only_integer: true, message: "Semester muss eine Jahreszahl sein." }
    validates :year, length: { is: 4, message: "Semester muss eine valides Jahr sein." }
    validates :year, inclusion: { in: 2000..2100, message: "Semester muss zwischen 2000 und 2100 liegen."}

    validates :period, presence: true




    # =====  TODO - Beispielaufgabe 3  =====
    #      
    # · Ergänze das Kürzel um eine Validierung, damit dieses maximal 10 Zeichen lang sein darf
    # · Füge beiden Validierungen eine eigene Fehlermeldung hinzu, die bei einem Fehler angezeigt wird

    validates :short_name, presence: { message: "Kürzel muss angegeben werden." }
    validates :short_name, length: { maximum: 10, message: "Kürzel darf maximal 10 Zeichen lang sein." }

    # ======================================



    # Methode für ausstehende Events
    def upcoming
        self.events.where("date >= ?", Date.today).order(date: :asc, time: :asc)
    end
end
