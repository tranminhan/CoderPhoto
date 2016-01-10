class CommentNotifyJob < ActiveJob::Base
  queue_as :comment_notify

  def perform(comment)
    CommentNotify.notify_owner comment
    CommentNotify.notify_other_commenters comment
  end
end
