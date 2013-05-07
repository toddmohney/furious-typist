class AddAuthorToArticle < ActiveRecord::Migration
  def up
    add_column :articles, :author_id, :integer
  end

  def down
    remove_column :articles, :author_id
  end
end
