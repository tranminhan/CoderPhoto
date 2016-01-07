class PhotosController < ApplicationController
  def index
  	@photos = Photo.all
  end

  def like
    @photo = Photo.find params[:id]
    @vote = @photo.liked_by! current_user
    # spawn another process
    # send email
    PhotoMailer.notify_likes(@vote).deliver_later
    render 'shared/like'
  end

  def unlike
    @photo = Photo.find params[:id]
    @photo.unliked_by! current_user
    render 'shared/like'
  end
end
