class AddKeyToHykuGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :hyku_groups, :key, :string, null: false
    add_index :hyku_groups, :key, unique: true
  end
end
