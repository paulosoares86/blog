class AddIsProjectToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_project, :boolean, default: false
  end
end
