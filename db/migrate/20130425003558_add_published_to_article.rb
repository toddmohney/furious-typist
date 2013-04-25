class AddPublishedToArticle < ActiveRecord::Migration
  def up
    add_column :articles, :published, :boolean, :default => false
  end

  def down
    remove_column :articles, :published
  end
end
