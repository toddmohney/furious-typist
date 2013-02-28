class Role < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :users

  # returns the admin role
  def self.admin
    where({ name: "admin" }).first
  end

  def self.user
    where({ name: "user" }).first
  end
end
