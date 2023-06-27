# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Event.delete_all
Course.delete_all

courses = Course.create([
    { name: "Mathematik für Informatiker 2", semester: 2, year: 2023, period: 0, short_name: "MafI2", faculty: "Informatik", lecturer: "Prof. Dr. Peter Buchholz", room: "SRG HS1" },
    { name: "Softwarepraktikum", semester: 2, year: 2023, period: 0, short_name: "SoPra", faculty: "Informatik", lecturer: "Dr. Stafan Naujokat", room: nil }
]);

events = Event.create([
    { title: "Klausur", date: "2023-08-03", time: "15:00:00", course: courses.first, "status": "Ausstehend" }
]);