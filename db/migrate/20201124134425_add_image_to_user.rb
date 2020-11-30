class AddImageToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image_file_name,    :string
    add_column :users, :image_content_type, :string
    add_column :users, :image_file_size,    :integer
    add_column :users, :image_updated_at,   :datetime
    remove_column :users, :image
    remove_column :users, :admin

  end
end
