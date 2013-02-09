class Article < ActiveRecord::Base
  attr_accessible :body,
                  :title,
                  :url,
                  :tags

  validates_presence_of :body,
                        :title,
                        :url

  has_and_belongs_to_many :tags
end
