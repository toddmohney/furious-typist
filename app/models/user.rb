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

  has_and_belongs_to_many :roles
  has_many :articles

  validates_presence_of :email
  validates_presence_of :username

  validate :name_validator

  after_initialize do |user|
    unless user.roles.present?
      user.roles << Role.where({ name: "user" })
    end
  end

  def full_name
    first_name + ' ' + last_name
  end

  def add_role(role)
    unless roles.include?(role)
      roles << role
    end
  end

  def remove_role(role_name)
    roles_to_delete = roles.where({ name: role_name })
    roles.delete(roles_to_delete)
  end

  def is_admin?
    roles.include?(Role.admin)
  end

  def is_admin=(is_admin)
    if is_admin
      add_role(Role.admin)
    else
      remove_role("admin")
    end
  end

  private

  def has_full_name?
    !(first_name.blank? || last_name.blank?)
  end

  def name_validator
    if has_full_name?
      first_name_errors = validate_name_format(first_name)
      last_name_errors = validate_name_format(last_name)
    elsif has_half_a_name?(first_name, last_name)
      first_name_errors = "is blank" if first_name.blank?
      last_name_errors = "is blank" if last_name.blank?
    end

    errors.add(:first_name, "first name " + first_name_errors) if first_name_errors.present?
    errors.add(:last_name, "last name " + last_name_errors) if last_name_errors.present?
  end

  def validate_name_format(name)
    return " is blank" if name.blank?
    return " is too short" if is_name_too_short?(name)
    return " is too long" if is_name_too_long?(name)
    return " has invalid characters" if name =~ /[^A-Za-z']/
  end

  def is_name_too_short?(name)
    name.length < 2
  end

  def is_name_too_long?(name)
    name.length > 64
  end

  def has_half_a_name?(first_name, last_name)
    !(first_name.blank? && last_name.blank?)
  end
end
