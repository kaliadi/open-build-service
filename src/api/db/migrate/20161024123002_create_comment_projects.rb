class CreateCommentProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_projects do |t|
      t.references :project
      t.references :package
      t.references :bs_request
      t.string :title
      t.text :body
      t.integer :parent_id
      t.string :user

      t.timestamps
    end
  end
end
