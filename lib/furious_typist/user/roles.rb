module FuriousTypist
  module User::Roles
    extend ActiveSupport::Concern

    included do
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
    end
  end
end
