class User < ActiveRecord::Base
  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :first_name,
                  :is_deleted,
                  :is_email_validated,
                  :is_enabled,
                  :last_name,
                  :username,
                  :is_admin

  has_many :articles
  has_and_belongs_to_many :roles

  validates_presence_of :email
  validates_presence_of :username
  validates :username, length: { maximum: 64 }

  after_initialize do |user|
    unless user.roles.present?
      user.roles << Role.where({ name: "user" })
    end
  end

  include User::Authenticatable
  include User::Naming
  include User::Roles
end
