class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.time :start_time
      t.time :end_time
      t.string :days
      t.references :subject, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.integer :teacher_id

      t.timestamps
    end
  end
end
