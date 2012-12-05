class MapsController < ApplicationController
  def show
  end
  def new
    @map = Map.new
  end
  def create
  end
  def edit
    @map = Map.find(params[:id])
  end
  def destroy
  end
end