class AddUserDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :full_name, :string, default: ''
    add_column :users, :role, :integer, default: 1
    add_column :users, :slug, :string
    add_column :users, :bio, :text
  end
end
