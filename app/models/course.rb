class Course < ApplicationRecord
    has_many :events, class_name: "Event", dependent: :delete_all

    # Validations
    validates :name, presence: { message: "Kursname muss angegeben werden." }
    validates :semester, presence: { message: "Fachsemester muss angegeben werden." }, numericality: { only_integer: true, message: "Fachsemester muss eine Zahl sein." }
    validates :year, presence: { message: "Semester muss angegeben werden." }, numericality: { only_integer: true, message: "Semester muss eine Jahreszahl sein." }, length: { is: 4, message: "Semester muss eine valides Jahr sein." }, inclusion: { in: 2000..2100, message: "Semester muss zwischen 2000 und 2100 liegen."}
    validates :period, presence: true
    validates :short_name, presence: { message: "Kürzel muss angegeben werden." }, length: { maximum: 10, message: "Kürzel darf maximal 10 Zeichen lang sein." }

    def upcoming
        self.events.where("date >= ?", Date.today).order(date: :asc, time: :asc)
    end
end
