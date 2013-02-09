class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :url
      t.string :title
      t.string :body
      t.integer :category_id
      t.timestamps
    end
  end
end
