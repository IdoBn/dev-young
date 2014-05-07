class RemoveContentFromLink < ActiveRecord::Migration
  def change
  	remove_column :links, :content
  end
end
