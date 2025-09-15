class AddUniqueIndexToEnrollments < ActiveRecord::Migration[8.0]
  def change
     remove_index :enrollments, :user_id
     add_index :enrollments, [:user_id, :section_id], unique: true, name: 'index_enrollments_on_user_id_and_section_id'
  end
end
