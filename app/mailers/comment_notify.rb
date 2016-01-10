class CommentNotify < ApplicationMailer

  def notify_owner(comment)
    @comment = comment
    commenter = comment.user
    owner = comment.photo.user

    debugger
    logger.debug "calling notify email"
    mail(to: owner.email, subject: "#{commenter.email} has commented on your photo!")
  end

  def notify_other_commenters(comment)
    @comment = comment
    commenter = comment.user
    # collect distinct commenters
    # send email to them
    other_commenters_email = @comment.photo.comments.collect { |e| e.user.email } .uniq
    debugger
    logger.debug "calling notify email to other commenters"
    other_commenters_email do |email|
      mail(to: email, subject: "#{commenter.email} commented on a photo that you also commented on!")
    end 
  end

end
