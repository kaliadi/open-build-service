class RemoveOldRelationsFromComments < ActiveRecord::Migration[5.0]
  def change
    change_table :comments do |c|
      c.remove_foreign_key :projects
      c.remove_foreign_key :packages
      c.remove_foreign_key :bs_requests
      c.remove_column :comments, :type
    end
  end
end
