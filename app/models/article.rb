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

  def markdown
    BlueCloth::new(body).to_html.html_safe
  end

  def get_tag_names
    @tag_list = ""

    unless tags.blank?
      tags.each do |t|
        @tag_list << t.name << ", "
      end

      if @tag_list.end_with?(", ")
        @tag_list = @tag_list[0..-2]
      end
    end

    @tag_list
  end
end
