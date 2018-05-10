class AddReadOnlyFlagToBindaFieldSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :binda_field_settings, :read_only, :boolean, default: false
  end
end
