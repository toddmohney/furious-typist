class User < ActiveRecord::Base
  attr_accessible :email,
                  :first_name,
                  :is_deleted,
                  :is_email_validated,
                  :is_enabled,
                  :last_name,
                  :username

  validates_presence_of :email,
                        :username

  def full_name
    first_name + ' ' + last_name
  end

end
