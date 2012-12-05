class PhotoController < ApplicationController
  def show
  end
  def new
    @photo = Photo.new
  end
  def create
  end
  def edit
    @photo = Photo.find(params[:id])
  end
  def destroy
  end
end