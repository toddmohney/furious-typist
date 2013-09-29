class Article < ActiveRecord::Base
  include Tire::Model::Search

  index_name "#{Tire::Model::Search.index_prefix}articles"

  attr_accessible :body,
                  :title,
                  :tags,
                  :category,
                  :created_at,
                  :updated_at,
                  :published

  validates_presence_of :body,
                        :title

  belongs_to :author, class_name: "User"
  belongs_to :category
  has_and_belongs_to_many :tags

  scope :published, where(published: true)
  scope :unpublished, where(published: false)

  after_save do
    update_index if searchable?
  end

  def searchable?
    published?
  end

  def get_tag_names
    @tag_names = []

    tags.each { |t| @tag_names << t.name } unless tags.blank?

    @tag_names.join(", ")
  end
end
