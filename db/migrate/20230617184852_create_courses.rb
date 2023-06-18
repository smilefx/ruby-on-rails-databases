class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :semester
      t.integer :year
      t.integer :period
      t.string :short_name
      t.string :faculty
      t.string :lecturer
      t.string :room

      t.timestamps
    end
  end
end
