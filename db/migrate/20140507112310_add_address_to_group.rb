class AddAddressToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :address, :string
  end
end
