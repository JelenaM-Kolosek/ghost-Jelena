class DeleteTeamMemberJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.destroy
  end
end
