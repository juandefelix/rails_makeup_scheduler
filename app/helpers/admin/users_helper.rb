module Admin::UsersHelper
  def all_users
    User.all.map { |user| [user.name, user.id] }
  end
end
