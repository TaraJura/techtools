class AddIpAddressToInstances < ActiveRecord::Migration[7.0]
  def change
    add_column :instances, :ip_address, :string
  end
end
