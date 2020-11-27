class ChangeUserRole < ActiveRecord::Migration[6.0]
  def change
    def change
      remove_column :users, :role
      add_column :users, :role, :integer, default: 1
    end
  end
end
