class AddPublicToInstances < ActiveRecord::Migration[7.0]
  def change
    add_column :instances, :public, :boolean
  end
end
