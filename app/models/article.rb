class Article < ActiveRecord::Base
  attr_accessible :body,
                  :title,
                  :url,
                  :tags,
                  :category,
                  :created_at,
                  :updated_at

  validates_presence_of :body,
                        :title,
                        :url

  has_and_belongs_to_many :tags
  belongs_to :category

  def get_tag_names
    @tag_list = ""

    tags.each do |t|
      @tag_list << t.name << " "
    end

    @tag_list
  end
end
