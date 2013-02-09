class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email,
                  :first_name,
                  :is_deleted,
                  :is_email_validated,
                  :is_enabled,
                  :last_name,
                  :username

  validates_presence_of :email
  validates_presence_of :username

  validate :username_validator
  validate :email_validator
  validate :name_validator

  def full_name
    first_name + ' ' + last_name
  end


  private

    def username_validator
      validate_username_format
    end


    def email_validator

    end

    def has_full_name?
      !(first_name.blank? || last_name.blank?)
    end

    def name_validator
      if has_full_name?
        @error_desc = validate_name_format(first_name, 2, 64)

        unless @error_desc.blank?
          return errors.add(:first_name, "first name " + @error_desc)
        end

        @error_desc = validate_name_format(last_name, 2, 64)

        unless @error_desc.blank?
          return errors.add(:last_name, "last name " + @error_desc)
        end

      elsif !(first_name.blank? && last_name.blank?)
          # we only have half a name
          if first_name.blank?
            return errors.add(:first_name, "first name is blank")
          end

          if last_name.blank?
            return errors.add(:last_name, "last name is blank")
          end
      end
    end


    def validate_username_format
      #if username.blank?
      #  return errors.add(:username, "username is blank")
      #end
      #
      #if username.length < 4
      #  return errors.add(:username, " is too short")
      #end
      #
      #if username.length > 64
      #  return errors.add(:username, " is too long")
      #end
      #
      #if username =~ /[^A-Za-z0-9]/
      #  return errors.add(:username, " has some invalid characters")
      #end
    end


    def validate_name_format(name, min_length =- 1, max_length = -1)
      if name.blank?
        return " is blank"
      end

      if min_length >= 0
        if name.length < min_length
          return " is too short"
        end
      end

      if max_length >= 0
        if name.length > max_length
          return " is too long"
        end
      end

      if name =~ /[^A-Za-z]/
        return " has invalid characters"
      end
    end

end
