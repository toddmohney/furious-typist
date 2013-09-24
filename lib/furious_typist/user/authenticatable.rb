module FuriousTypist
  module User::Authenticatable
    extend ActiveSupport::Concern

    included do
    devise :database_authenticatable,
           :registerable,
           :recoverable,
           :rememberable,
           :trackable,
           :validatable
    end
  end
end
