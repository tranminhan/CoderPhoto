class CommentsController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    comment = Comment.new(content: params[:content], user: current_user)
    @photo.comments << comment
    
    respond_to do |format|
      format.html do
        if @photo.save
          redirect_to photos_path
        else 
          flash[:error] = "Error when commenting...."
          redirect_to photos_path
        end 
      end

      format.js
    end
  end

  def like
    @comment = Comment.find params[:id]
    @like = @comment.liked_by! current_user
    # spawn another process
    # send email
    # PhotoMailer.notify_likes(@vote).deliver_later
    @photo = @comment.photo
    render 'shared/like'
  end

  def unlike
    @comment = Comment.find params[:id]
    @comment.unliked_by! current_user
    @photo = @comment.photo
    render 'shared/like'
  end

end
