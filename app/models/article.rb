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

    tags.each { |t| @tag_names << t.name } unless tags.blank?

    @tag_names.join(", ")
  end

  def searchable?
    published
  end

  searchable if: :searchable? do
    text :title, boost: 1000
    text :body, boost: 500

    integer :category_id
    integer :tag_ids, multiple: true
  end
end
