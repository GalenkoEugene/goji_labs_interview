class UpdateSections < ActiveRecord::Migration[8.0]
  def up
    change_column :sections, :days, :string, array: true, default: [], using: "ARRAY[days]::VARCHAR[]"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't revert days column to string, please implement data migration if needed"
  end
end
