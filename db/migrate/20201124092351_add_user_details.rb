class AddUserDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image, :string
    add_column :users, :full_name, :string
    add_column :users, :role, :string
    add_column :users, :slug, :string
    add_column :users, :bio, :text
  end
end
