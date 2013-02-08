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

  validate :username_validator
  validate :email_validator
  validate :name_validator

  def full_name
    first_name + ' ' + last_name
  end


  private

    def username_validator

    end


    def email_validator

    end


    def name_validator
      if first_name.blank? && last_name.blank?
        # the name only needs validating if we have a first and last name
        return
      end

      @error_desc = validate_name_format(first_name, 2, 64)

      unless @error_desc.blank?
        return errors.add(:first_name, "first name " + @error_desc)
      end

      @error_desc = validate_name_format(last_name, 2, 64)

      unless @error_desc.blank?
        return errors.add(:last_name, "last name " + @error_desc)
      end
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
