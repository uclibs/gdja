class StatusChannel < ApplicationCable::Channel
  def subscribed
    account = AccountStatus.new(current_account)
    stream_from account
  end

  def unsubscribed
    # No cleanup needed
  end
end
