class CommentNotifyMailer < ApplicationMailer

  def notify_owner(comment)
    @comment = comment
    logger.debug "calling notify email"
    mail(to: "admin@example.com", subject: "someone has commented on your photo!")
  end

  def notify_other_commenters(comment)
    @comment = comment
    commenter = comment.user
    # collect distinct commenters
    # send email to them
    other_commenters_email = @comment.photo.comments.collect { |e| e.user.email } .uniq
    debugger
    logger.debug "calling notify email to other commenters"
    other_commenters_email.each do |email|
      mail(to: email, subject: "#{commenter.email} commented on a photo that you also commented on!")
    end 
  end

end
