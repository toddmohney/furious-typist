class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Article do |article|
      user.present? &&
        (user.is_admin? || article.author == user)
    end

    can :read, Article, published?: true

    can :manage, User do
      user && user.is_admin?
    end

    can :read, User do
      false
    end
  end
end
