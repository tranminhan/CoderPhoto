class CommentNotifyJob < ActiveJob::Base
  queue_as :comment_notify

  def perform(comment)
    logger.debug ">>> running job"
    CommentNotify.notify_owner(comment)
    logger.debug ">>> notify 1"
    CommentNotify.notify_other_commenters(comment)
    logger.debug ">>> notify 2"
  end
end
