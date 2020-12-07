class InvitationsController < Devise::InvitationsController
  def invite_resource
    User.invite!(invite_params, current_user) do |invitable|
      invitable.update!(role: invite_params[:role])
      redirect_to user_team_path(current_user), notice: 'Invitation has been sent successfully'
    end
  end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params) # Report accepting invitation to analytics
    Analytics.report('invite.accept', resource.id)
    resource
  end

  def invite_params
    params.require(:user).permit(:email, :role)
  end
end
