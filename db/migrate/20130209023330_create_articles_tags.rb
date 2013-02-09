class CreateArticlesTags < ActiveRecord::Migration
  def up
    create_table :articles_tags, :id => false do |t|
      t.integer :article_id, :null => false
      t.integer :tag_id, :null => false
    end

    add_index :articles_tags, [:article_id, :tag_id], :unique => true
  end

  def down
    remove_index :articles_tags, :column => [:article_id, :tag_id]
    drop_table :articles_tags
  end
end
