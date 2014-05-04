class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :group_confirm, default: false
      t.boolean :user_confirm, default: false

      t.timestamps
    end
  end
end
