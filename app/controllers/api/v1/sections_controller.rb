class Api::V1::SectionsController < ApplicationController
  def index
    @sections = Section.includes(:subject, :teacher, :classroom).all
    render json: @sections
  end

  def show
    @section = Section.find(params[:id])
    render json: @section
  end
end
