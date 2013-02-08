class Article < ActiveRecord::Base
  attr_accessible :body,
                  :title,
                  :url

  validates_presence_of :body,
                        :title,
                        :url
end
