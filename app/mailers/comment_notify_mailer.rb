class CommentNotifyMailer < ApplicationMailer

  def notify_owner(comment)
    @comment = comment
    @user = User.where('email = ?', comment.photo.username).first
    if @user.opt_in?
      mail(to: "admin@example.com", subject: "someone has commented on your photo!")
    end
  end

  def notify_other_commenters(comment)
    @comment = comment
    commenter = comment.user
    # collect distinct commenters
    # send email to them
    other_commenters_email = @comment.photo.comments.collect { |e| e.user.email } .uniq
    other_commenters_email.each do |email|
      @user = User.where('email = ?', email).first
      if @user.opt_in?
        mail(to: email, subject: "#{commenter.email} commented on a photo that you also commented on!")
      end 
    end 
  end

end
