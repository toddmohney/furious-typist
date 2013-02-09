class Category < ActiveRecord::Base
  attr_accessible :description,
                  :name

  validates_presence_of :name,
                        :description

  has_many :articles
end
