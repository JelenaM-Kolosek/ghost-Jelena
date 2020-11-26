class AddFullNameDefaultValue < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :full_name
    add_column :users, :full_name, :string, default: ''
  end
end
