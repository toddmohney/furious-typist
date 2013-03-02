class Role < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :users

  # returns the admin role
  def self.admin
    find_or_create_by_name("admin")
  end

  def self.user
    find_or_create_by_name("user")
  end
end
