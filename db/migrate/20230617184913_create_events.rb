class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :status
      t.date :date
      t.time :time
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
