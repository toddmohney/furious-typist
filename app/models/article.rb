class Article < ActiveRecord::Base
  attr_accessible :body,
                  :title,
                  :tags,
                  :category,
                  :created_at,
                  :updated_at,
                  :published

  validates_presence_of :body,
                        :title

  has_and_belongs_to_many :tags
  belongs_to :category

  scope :published, where(published: true)
  scope :unpublished, where(published: false)

  def markdown
    BlueCloth::new(body).to_html.html_safe
  end

  def get_tag_names
    @tag_names = []

    unless tags.blank?
      tags.each do |t|
        @tag_names << t.name
      end
    end

    @tag_names.join(", ")
  end
end
