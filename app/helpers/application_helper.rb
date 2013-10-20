module ApplicationHelper

  def sign_as_admin?
    current_user.present? && current_user.staff.approved
  end

end
