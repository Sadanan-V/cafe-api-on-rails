class Api::V1::CafesController < ApplicationController
  def index
    if params[:title].present?
      # if there is param, shows only relevant cafes
      @cafes = Cafe.where('title ILIKE ?', "%#{params[:title]}%")
    else
      @cafes = Cafe.all
    end
    render json: @cafes.order(created_at: :desc)
  end

  def create
    @cafe = Cafe.new(cafe_params)
    if @cafe.save
      render json: @cafe, status: :created
    else
      render json: { error: @cafe.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def cafe_params
    params.require(:cafe).permit(:title, :address, :picture, hours: {}, criteria: [])
  end
end
