module FuriousTypist
  module User::Naming
    extend ActiveSupport::Concern

    included do
      validates_presence_of :first_name, unless: Proc.new { |user| user.last_name.blank? }
      validates :first_name, length: { maximum: 64 }

      validates_presence_of :last_name, unless: Proc.new { |user| user.first_name.blank? }
      validates :last_name, length: { maximum: 64 }

      def full_name
        first_name + ' ' + last_name
      end

      private

      def has_full_name?
        first_name.present? && last_name.present?
      end
    end

  end
end
