class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :content
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
