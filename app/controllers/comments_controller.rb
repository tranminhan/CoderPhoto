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
end
